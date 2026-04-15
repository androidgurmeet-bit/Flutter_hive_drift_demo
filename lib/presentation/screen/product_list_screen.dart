import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_benchmark_app/domain/entity/product_benchmark.dart';
import 'package:product_benchmark_app/presentation/bloc/product_bloc.dart';
import 'package:product_benchmark_app/presentation/bloc/product_state.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Benchmark')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading || state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          if (state is! ProductLoaded) {
            return const SizedBox.shrink();
          }

          final products = state.result.products;
          final benchmark = state.result.benchmark;

          return Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.amber.shade50,
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Source: ${benchmark.sourceLabel} | Mode: ${benchmark.storageMode.label} | Count: ${benchmark.itemCount} | '
                  'Payload: ${_formatBytes(benchmark.payloadBytes)} | '
                  '${_formatSourceTiming(benchmark)} | '
                  'Hive: ${_formatBenchmark(benchmark.hiveWriteTimeMs, benchmark.hiveReadTimeMs)} | '
                  'Drift: ${_formatBenchmark(benchmark.driftWriteTimeMs, benchmark.driftReadTimeMs)}',
                  style: TextStyle(
                    color: Colors.amber.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.productUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint(
                              'Image load failed for ${product.productUrl}: $error',
                            );
                            return Container(
                              width: 56,
                              height: 56,
                              color: Colors.grey.shade200,
                              alignment: Alignment.center,
                              child: const Icon(Icons.broken_image_outlined),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Price: ${product.price}  Qty: ${product.quantity}',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
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

String _formatSourceTiming(ProductBenchmark benchmark) {
  if (benchmark.isLocalGeneration) {
    return 'Generate: ${benchmark.generationTimeMs} ms';
  }

  return 'Fetch: ${benchmark.fetchTimeMs} ms | Decode: ${benchmark.decodeTimeMs} ms';
}
