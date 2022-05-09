import 'package:flutter/widgets.dart';
import 'package:wam_streams/models/process_model.dart';

class ProcessQueueViewModel with ChangeNotifier {
  List<ProcessModel> processes = [];

  void addProcessToQueue(ProcessModel processModel) {
    processes.add(processModel);
  }
}
