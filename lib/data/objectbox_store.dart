import '../objectbox.g.dart';

late final Store objectBoxStore;

Future<void> initObjectBox() async {
  objectBoxStore = await openStore();
}
