class ApiConfig {
  static const String _largeTestProductsCountValue = String.fromEnvironment(
    'LARGE_TEST_PRODUCTS_COUNT',
  );

  static int? get largeTestProductsCount {
    if (_largeTestProductsCountValue.isEmpty) {
      return null;
    }

    return int.tryParse(_largeTestProductsCountValue);
  }
}
