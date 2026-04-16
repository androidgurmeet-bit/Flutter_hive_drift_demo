import 'package:drift/drift.dart' show Value;
import 'package:product_benchmark_app/data/model/product_model.dart';
import 'package:product_benchmark_app/data/service/product_drift_database.dart';

class ProductDriftDataSource {
  final ProductDriftDatabase database;

  ProductDriftDataSource({ProductDriftDatabase? database})
    : database = database ?? ProductDriftDatabase.instance;

  Future<void> initialize() async {
    await database.initialize();
  }

  Future<void> saveProducts(List<ProductModel> products) async {
    await database.transaction(() async {
      await database.delete(database.driftProducts).go();
      await database.batch((batch) {
        batch.insertAll(
          database.driftProducts,
          products
              .map(
                (product) => DriftProductsCompanion.insert(
                  id: Value(product.id),
                  name: product.name,
                  price: product.price,
                  productUrl: product.productUrl,
                  quantity: product.quantity,
                  description: Value(product.description),
                ),
              )
              .toList(),
        );
      });
    });
  }

  Future<List<ProductModel>> getProducts() async {
    final rows = await database.select(database.driftProducts).get();
    return rows
        .map(
          (row) => ProductModel(
            id: row.id,
            name: row.name,
            price: row.price,
            productUrl: row.productUrl,
            quantity: row.quantity,
            description: row.description,
          ),
        )
        .toList();
  }

  Future<void> saveProduct(ProductModel product) async {
    await database.into(database.driftProducts).insertOnConflictUpdate(
      DriftProductsCompanion.insert(
        id: Value(product.id),
        name: product.name,
        price: product.price,
        productUrl: product.productUrl,
        quantity: product.quantity,
        description: Value(product.description),
      ),
    );
  }

  Future<ProductModel?> getProduct(int productId) async {
    final query = database.select(database.driftProducts)
      ..where((table) => table.id.equals(productId));
    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }

    return ProductModel(
      id: row.id,
      name: row.name,
      price: row.price,
      productUrl: row.productUrl,
      quantity: row.quantity,
    );
  }

  Future<void> clearProducts() async {
    await database.delete(database.driftProducts).go();
  }

  Future<void> setLastSyncTime(DateTime time) async {
    await database.into(database.driftProductMetadata).insertOnConflictUpdate(
      DriftProductMetadataCompanion.insert(
        key: 'last_product_sync',
        intValue: Value(time.millisecondsSinceEpoch),
      ),
    );
  }
}