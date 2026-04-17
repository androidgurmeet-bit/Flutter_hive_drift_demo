enum ProductStorageMode {
  hiveOnly,
  driftOnly,
  objectBoxOnly,
  dualWrite;

  String get label {
    switch (this) {
      case ProductStorageMode.hiveOnly:
        return 'Hive only';
      case ProductStorageMode.driftOnly:
        return 'Drift only';
      case ProductStorageMode.objectBoxOnly:
        return 'ObjectBox only';
      case ProductStorageMode.dualWrite:
        return 'Hive + Drift';
    }
  }

  bool get writesHive => this == ProductStorageMode.hiveOnly || this == ProductStorageMode.dualWrite;

  bool get writesDrift => this == ProductStorageMode.driftOnly || this == ProductStorageMode.dualWrite;

  bool get writesObjectBox => this == ProductStorageMode.objectBoxOnly;
}