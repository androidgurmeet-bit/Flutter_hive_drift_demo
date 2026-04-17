import 'package:objectbox/objectbox.dart';
import 'package:product_benchmark_app/data/model/product_model.dart';
import 'package:product_benchmark_app/data/model/product_objectbox_model.dart';

class ProductObjectBoxDataSource {
  final Box<ProductObjectBox> _box;

  ProductObjectBoxDataSource(Store store)
      : _box = store.box<ProductObjectBox>();

  Future<void> saveProducts(List<ProductModel> products) async {
    _box.removeAll();
    final entities = products.map(ProductObjectBox.fromModel).toList();
    _box.putMany(entities);
  }

  Future<List<ProductModel>> getProducts() async {
    final entities = _box.getAll();
    return entities.map((e) => e.toModel()).toList();
  }

  Future<ProductModel?> getProduct(int productId) async {
    final entity = _box.get(productId);
    return entity?.toModel();
  }

  Future<void> clearProducts() async {
    _box.removeAll();
  }
}
