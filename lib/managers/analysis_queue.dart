import 'dart:async';
import 'dart:collection';
import 'package:synchronized/synchronized.dart';
import 'package:wam_streams/models/process_model.dart';

class ProcessModelReference {
  final String processModelId;

  ProcessModelReference({
    required this.processModelId,
  });
}

abstract class ProcessQueue {
  Future<void> initialize();
  int? positionOfProcessOnQueue(ProcessModel processModel);
  bool isProcessInProgress(ProcessModel processModel);
  Future<void> addProcessToQueue(ProcessModel processModel);
  Future<void> beginProcessing();
  Future<void> _finishProcess();
}

class AnalysisQueue implements ProcessQueue {
  static final AnalysisQueue _instance = AnalysisQueue._internal();
  AnalysisQueue._internal();

  factory AnalysisQueue() {
    return _instance;
  }

  @override
  Future<void> initialize() async {
    return Future.value();
  }

  double _progress = 0.0;
  Queue<ProcessModelReference> _queue = Queue();
  var _lock = new Lock();

  final StreamController progressStreamController = StreamController<double?>.broadcast();
  final StreamController analysisQueueStreamController = StreamController<Queue<ProcessModelReference>>.broadcast();

  @override
  int? positionOfProcessOnQueue(ProcessModel processModel) {
    int? indexOfProcess =
        _queue.toList().indexWhere((processModelOnQueue) => processModelOnQueue.processModelId == processModel.id);

    return indexOfProcess != -1 ? indexOfProcess : null;
  }

  @override
  bool isProcessInProgress(ProcessModel processModel) {
    ProcessModelReference? processModelInProgress = _queue.length > 0 ? _queue.first : null;
    return processModelInProgress != null ? processModelInProgress.processModelId == processModel.id : false;
  }

  @override
  Future<void> addProcessToQueue(ProcessModel processModel) async {
    /// Example 1: Adding a processModel to the queue
    _queue.add(ProcessModelReference(processModelId: processModel.id!)); // First we update the queue property
    analysisQueueStreamController.sink
        .add(_queue); // then we send the whole updated data object queue by using sink.add

    /// US408001: Analysis Queue
    /// Using the lock so that we process processModels in order and one at a time
    await _lock.synchronized(() async {
      await beginProcessing();
      await _finishProcess();
      return Future.value();
    });
  }

  @override
  Future<void> beginProcessing() async {
    _progress = 0;
    progressStreamController.sink.add(_progress);

    for (var i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      /// US408001: Analysis Queue
      /// Here is where we update this progress value. We should do this after an image is processed
      /// To initialize or save the progress of a Process, we can have a computed value on the processModel object
      /// that is the (number of already processed images) / (images included)
      _progress = _progress + 0.1;
      progressStreamController.sink.add(_progress);
    }

    return Future.value();
  }

  @override
  Future<void> _finishProcess() {
    /// Example 2: Removing a processModel from the queue
    _queue.removeFirst(); // First we update the queue property
    analysisQueueStreamController.sink
        .add(_queue); // then we send the whole updated data object queue by using sink.add

    return Future.value();
  }
}
