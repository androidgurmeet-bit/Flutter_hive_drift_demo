import 'package:product_benchmark_app/data/model/product_objectbox_model.dart';
import 'package:objectbox/objectbox.dart';

class ObjectBoxDebugUtil {
  ObjectBoxDebugUtil._();

  static void logStoreStatistics(Store store) {
    final box = store.box<ProductObjectBox>();
    final count = box.count();
    print('[ObjectBox] Total products: $count');
  }
}
