import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wam_streams/managers/analysis_queue.dart';
import 'package:wam_streams/models/process_model.dart';
import 'package:wam_streams/view_models/process_queue_view_model.dart';

class AddToQueueScreen extends StatefulWidget {
  const AddToQueueScreen({Key? key}) : super(key: key);

  @override
  State<AddToQueueScreen> createState() => _AddToQueueScreenState();
}

class _AddToQueueScreenState extends State<AddToQueueScreen> {
  late ProcessQueueViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ProcessQueueViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tap the + icon to add a process to the queue \n Number of processes overall: ${viewModel.processes.length}',
              ),
              Text(
                '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _onPressed,
          child: const Icon(Icons.add),
        ));
  }

  void _onPressed() {
    setState(() {
      var processModel = ProcessModel(viewModel.processes.length);
      AnalysisQueue().addProcessToQueue(processModel);
      viewModel.addProcessToQueue(processModel);
    });
  }
}
