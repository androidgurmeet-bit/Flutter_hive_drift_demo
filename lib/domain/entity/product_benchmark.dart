import 'package:product_benchmark_app/data/config/product_storage_mode.dart';

class ProductBenchmark {
  final ProductStorageMode storageMode;
  final String sourceLabel;
  final bool isLocalGeneration;
  final int itemCount;
  final int payloadBytes;
  final int fetchTimeMs;
  final int decodeTimeMs;
  final int generationTimeMs;
  final int? hiveWriteTimeMs;
  final int? hiveReadTimeMs;
  final int hiveReadItems;
  final int? driftWriteTimeMs;
  final int? driftReadTimeMs;
  final int driftReadItems;
  final int? objectBoxWriteTimeMs;
  final int? objectBoxReadTimeMs;
  final int objectBoxReadItems;

  const ProductBenchmark({
    required this.storageMode,
    required this.sourceLabel,
    required this.isLocalGeneration,
    required this.itemCount,
    required this.payloadBytes,
    required this.fetchTimeMs,
    required this.decodeTimeMs,
    required this.generationTimeMs,
    this.hiveWriteTimeMs,
    this.hiveReadTimeMs,
    required this.hiveReadItems,
    this.driftWriteTimeMs,
    this.driftReadTimeMs,
    required this.driftReadItems,
    this.objectBoxWriteTimeMs,
    this.objectBoxReadTimeMs,
    this.objectBoxReadItems = 0,
  });
}
