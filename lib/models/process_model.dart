import 'package:uuid/uuid.dart';

class ProcessModel {
  int number;
  String? id;
  ProcessModel(this.number, [this.id]) {
    id = const Uuid().v4();
  }
}
