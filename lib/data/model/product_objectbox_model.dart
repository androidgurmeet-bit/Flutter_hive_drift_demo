import 'package:objectbox/objectbox.dart';
import 'package:product_benchmark_app/data/model/product_model.dart';

@Entity()
class ProductObjectBox {
  @Id(assignable: true)
  int id;

  String name;
  double price;
  String productUrl;
  int quantity;
  String? description;

  ProductObjectBox({
    this.id = 0,
    required this.name,
    required this.price,
    required this.productUrl,
    required this.quantity,
    this.description,
  });

  factory ProductObjectBox.fromModel(ProductModel model) {
    return ProductObjectBox(
      id: model.id,
      name: model.name,
      price: model.price,
      productUrl: model.productUrl,
      quantity: model.quantity,
      description: model.description,
    );
  }

  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      price: price,
      productUrl: productUrl,
      quantity: quantity,
      description: description,
    );
  }
}
