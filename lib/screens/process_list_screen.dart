import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wam_streams/components/progress_text_tile.dart';
import 'package:wam_streams/components/text_list_with_subtitle.dart';
import 'package:wam_streams/managers/analysis_queue.dart';

import '../view_models/process_queue_view_model.dart';

class ProcessListScreen extends StatefulWidget {
  const ProcessListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProcessListScreen> createState() => _ProcessListScreenState();
}

class _ProcessListScreenState extends State<ProcessListScreen> {
  late ProcessQueueViewModel viewModel;
  StreamSubscription<Queue<ProcessModelReference>>? subscription;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ProcessQueueViewModel>(context, listen: false);
    listenToQueue();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void listenToQueue() {
    subscription = AnalysisQueue().analysisQueueStreamController.stream.listen((event) async {
      if (!mounted) {
        return;
      }
      setState(() {});
    }) as StreamSubscription<Queue<ProcessModelReference>>?;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: viewModel.processes.length,
      itemBuilder: (BuildContext context, int index) {
        var process = viewModel.processes[index];

        if (AnalysisQueue().isProcessInProgress(process)) {
          return ProgressTextTile(
            title: 'Process ${process.number}',
            subtitle1: process.id,
            isFirst: index == 0,
            isLast: index == viewModel.processes.length - 1 || viewModel.processes.length == 1,
            onTap: (_) {},
          );
        } else {
          String? queuePosition;
          int? positionOfResultOnQueue = AnalysisQueue().positionOfProcessOnQueue(process);
          if (positionOfResultOnQueue != null) {
            queuePosition = "On Queue  - place $positionOfResultOnQueue";
          }

          return TextListTileWithSubtitle(
            title: 'Process ${process.number}',
            subtitle1: process.id,
            subtitle2: queuePosition,
            isFirst: index == 0,
            isLast: index == viewModel.processes.length - 1 || viewModel.processes.length == 1,
            onTap: (_) {
              AnalysisQueue().addProcessToQueue(process);

              setState(() {});
            },
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          child: Divider(
            indent: 14,
            thickness: 1,
            color: Theme.of(context).dividerColor,
            height: 1,
          ),
        );
      },
    );
  }
}
