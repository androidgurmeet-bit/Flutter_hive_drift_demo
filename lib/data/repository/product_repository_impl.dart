import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:product_benchmark_app/data/config/product_storage_mode.dart';
import 'package:product_benchmark_app/data/datasource/product_drift_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_hive_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_objectbox_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_remote_data_source.dart';
import 'package:product_benchmark_app/data/model/fetch_products_result.dart';
import 'package:product_benchmark_app/domain/entity/product_benchmark.dart';
import 'package:product_benchmark_app/domain/entity/product_load_result.dart';
import 'package:product_benchmark_app/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductHiveDataSource hiveDataSource;
  final ProductDriftDataSource driftDataSource;
  final ProductObjectBoxDataSource objectBoxDataSource;

  ProductRepositoryImpl(
    this.remoteDataSource,
    this.hiveDataSource,
    this.driftDataSource,
    this.objectBoxDataSource,
  );

  @override
  Future<ProductLoadResult> getProducts({
    int? largeTestCount,
    ProductStorageMode storageMode = ProductStorageMode.dualWrite,
  }) async {
    _printLog(
      'Starting product load. '
      'source=local generator, '
      'count=${largeTestCount ?? 'default'}, '
      'mode=${storageMode.label}',
    );

    final remoteResult = await remoteDataSource.fetchProducts(
      largeTestCount: largeTestCount,
    );

    _printLog(
      'Source load complete. '
      'source=${remoteResult.sourceLabel}, '
      'items=${remoteResult.products.length}, '
      'payload=${_formatBytes(remoteResult.responseBytes)} '
      '(${remoteResult.responseBytes} bytes), '
      '${_formatSourceTiming(remoteResult)}',
    );

    int? hiveWriteMs;
    int? hiveReadMs;
    var hiveReadItems = 0;

    if (storageMode.writesHive) {
      _printLog('Hive write started. items=${remoteResult.products.length}');
      final saveWatch = Stopwatch()..start();
      //await hiveDataSource.saveProducts(remoteResult.products);
      await hiveDataSource.saveProductsWithIsolate(remoteResult.products);
      saveWatch.stop();
      hiveWriteMs = saveWatch.elapsedMilliseconds;
      _printLog('Hive write completed in $hiveWriteMs ms');

      final readWatch = Stopwatch()..start();
      final hiveProducts = await hiveDataSource.getProductsWithIsolate();
      readWatch.stop();
      hiveReadMs = readWatch.elapsedMilliseconds;
      hiveReadItems = hiveProducts.length;
      _printLog(
        'Hive read-back completed in $hiveReadMs ms. items=$hiveReadItems',
      );
      await hiveDataSource.setLastSyncTime(DateTime.now());
    }

    int? driftWriteMs;
    int? driftReadMs;
    var driftReadItems = 0;

    if (storageMode.writesDrift) {
      _printLog('Drift write started. items=${remoteResult.products.length}');
      final saveWatch = Stopwatch()..start();
      await driftDataSource.saveProducts(remoteResult.products);
      saveWatch.stop();
      driftWriteMs = saveWatch.elapsedMilliseconds;
      _printLog('Drift write completed in $driftWriteMs ms');

      final readWatch = Stopwatch()..start();
      final driftProducts = await driftDataSource.getProducts();
      readWatch.stop();
      driftReadMs = readWatch.elapsedMilliseconds;
      driftReadItems = driftProducts.length;
      _printLog(
        'Drift read-back completed in $driftReadMs ms. items=$driftReadItems',
      );
      await driftDataSource.setLastSyncTime(DateTime.now());
    }

    int? objectBoxWriteMs;
    int? objectBoxReadMs;
    var objectBoxReadItems = 0;

    if (storageMode.writesObjectBox) {
      _printLog('ObjectBox write started. items=${remoteResult.products.length}');
      final saveWatch = Stopwatch()..start();
      await objectBoxDataSource.saveProducts(remoteResult.products);
      saveWatch.stop();
      objectBoxWriteMs = saveWatch.elapsedMilliseconds;
      _printLog('ObjectBox write completed in $objectBoxWriteMs ms');

      final readWatch = Stopwatch()..start();
      final objectBoxProducts = await objectBoxDataSource.getProducts();
      readWatch.stop();
      objectBoxReadMs = readWatch.elapsedMilliseconds;
      objectBoxReadItems = objectBoxProducts.length;
      _printLog(
        'ObjectBox read-back completed in $objectBoxReadMs ms. items=$objectBoxReadItems',
      );
    }

    _printLog(
      'Benchmark summary | mode=${storageMode.label} | '
      'source=${remoteResult.sourceLabel} | '
      'items=${remoteResult.products.length} | '
      'payload=${_formatBytes(remoteResult.responseBytes)} | '
      '${_formatSourceTiming(remoteResult)} | '
      'hive=${_formatBenchmark(hiveWriteMs, hiveReadMs)} | '
      'drift=${_formatBenchmark(driftWriteMs, driftReadMs)} | '
      'objectbox=${_formatBenchmark(objectBoxWriteMs, objectBoxReadMs)}',
    );

    return ProductLoadResult(
      products: remoteResult.products,
      benchmark: ProductBenchmark(
        storageMode: storageMode,
        sourceLabel: remoteResult.sourceLabel,
        isLocalGeneration: remoteResult.isLocalGeneration,
        itemCount: remoteResult.products.length,
        payloadBytes: remoteResult.responseBytes,
        fetchTimeMs: remoteResult.requestTimeMs,
        decodeTimeMs: remoteResult.decodeTimeMs,
        generationTimeMs: remoteResult.generationTimeMs,
        hiveWriteTimeMs: hiveWriteMs,
        hiveReadTimeMs: hiveReadMs,
        hiveReadItems: hiveReadItems,
        driftWriteTimeMs: driftWriteMs,
        driftReadTimeMs: driftReadMs,
        driftReadItems: driftReadItems,
        objectBoxWriteTimeMs: objectBoxWriteMs,
        objectBoxReadTimeMs: objectBoxReadMs,
        objectBoxReadItems: objectBoxReadItems,
      ),
    );
  }
}

String _formatSourceTiming(FetchProductsResult result) {
  if (result.isLocalGeneration) {
    return 'generation time=${result.generationTimeMs} ms';
  }

  return 'fetch time=${result.requestTimeMs} ms, decode time=${result.decodeTimeMs} ms';
}

String _formatBytes(int bytes) {
  const units = ['B', 'KB', 'MB', 'GB'];
  var value = bytes.toDouble();
  var unitIndex = 0;

  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex++;
  }

  return '${value.toStringAsFixed(unitIndex == 0 ? 0 : 2)} ${units[unitIndex]}';
}

String _formatBenchmark(int? writeMs, int? readMs) {
  if (writeMs == null || readMs == null) {
    return 'off';
  }

  return 'W:${writeMs}ms R:${readMs}ms';
}

void _printLog(String message) {
  final formatted = '[ProductRepository] $message';
  debugPrint(formatted);
  log(formatted, name: 'ProductRepository');
}
