enum ProductStorageMode {
  hiveOnly,
  driftOnly,
  dualWrite;

  String get label {
    switch (this) {
      case ProductStorageMode.hiveOnly:
        return 'Hive only';
      case ProductStorageMode.driftOnly:
        return 'Drift only';
      case ProductStorageMode.dualWrite:
        return 'Hive + Drift';
    }
  }

  bool get writesHive => this != ProductStorageMode.driftOnly;

  bool get writesDrift => this != ProductStorageMode.hiveOnly;
}