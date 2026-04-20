import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_benchmark_app/data/config/api_config.dart';
import 'package:product_benchmark_app/data/config/product_storage_mode.dart';
import 'package:product_benchmark_app/data/datasource/product_drift_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_hive_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_objectbox_data_source.dart';
import 'package:product_benchmark_app/data/datasource/product_remote_data_source.dart';
import 'package:product_benchmark_app/data/objectbox_store.dart';
import 'package:product_benchmark_app/data/repository/product_repository_impl.dart';
import 'package:product_benchmark_app/data/service/app_storage_initializer.dart';
import 'package:product_benchmark_app/domain/usecase/get_products_use_case.dart';
import 'package:product_benchmark_app/presentation/bloc/product_bloc.dart';
import 'package:product_benchmark_app/presentation/bloc/product_event.dart';
import 'package:product_benchmark_app/presentation/screen/product_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await AppStorageInitializer.initialize();
  } catch (e, stackTrace) {
    print('Initialization error: $e');
    rethrow;
  }

  final remoteDataSource = ProductRemoteDataSource();
  final hiveDataSource = ProductHiveDataSource();
  final driftDataSource = ProductDriftDataSource();
  final objectBoxDataSource = ProductObjectBoxDataSource(objectBoxStore);
  final repository = ProductRepositoryImpl(
    remoteDataSource,
    hiveDataSource,
    driftDataSource,
    objectBoxDataSource,
  );

  runApp(MainApp(useCase: GetProductsUseCase(repository)));
}

class MainApp extends StatelessWidget {
  final GetProductsUseCase useCase;

  const MainApp({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: BlocProvider(
        create: (context) => ProductBloc(useCase)
          ..add(
            LoadProductsEvent(
              largeTestCount: ApiConfig.largeTestProductsCount ?? 50000,
              storageMode: ProductStorageMode.objectBoxOnly,
            ),
          ),
        child: const ProductListScreen(),
      ),
    );
  }
}
