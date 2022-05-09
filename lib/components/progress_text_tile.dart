import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wam_streams/managers/analysis_queue.dart';

class ProgressTextTile extends StatefulWidget {
  const ProgressTextTile({
    Key? key,
    this.title,
    this.subtitle1,
    this.height,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);
  final void Function(BuildContext) onTap;
  final double defaultHeight = 72;
  final double? height;
  final String? title;
  final String? subtitle1;
  final bool isFirst;
  final bool isLast;

  @override
  _ProgressTextTileState createState() => _ProgressTextTileState(
      title: title,
      subtitle1: subtitle1,
      height: height,
      onTap: onTap,
      isFirst: isFirst,
      isLast: isLast);
}

class _ProgressTextTileState extends State<ProgressTextTile> with TickerProviderStateMixin {
  _ProgressTextTileState({
    Key? key,
    this.title,
    this.subtitle1,
    this.height,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  });
  final void Function(BuildContext) onTap;
  final double defaultHeight = 72;
  final double? height;
  final String? title;
  final String? subtitle1;
  final bool isFirst;
  final bool isLast;
  StreamSubscription<double?>? subscription;
  double? progress = 0.0;

  @override
  void initState() {
    super.initState();
    listenToProgress();
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void listenToProgress() {
    AnalysisQueue().progressStreamController.stream.listen((progressValue) async {
      if (!mounted) {
        return;
      }

      setState(() {
        progress = progressValue;
      });
    }) as StreamSubscription<double?>?;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
        color: Colors.white,
        child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: isFirst ? BorderSide(width: 0.5, color: Theme.of(context).dividerColor) : BorderSide.none,
              bottom: isLast ? BorderSide(width: 1, color: Theme.of(context).dividerColor) : BorderSide.none,
            )),
            height: height ?? defaultHeight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 9.5, 20, 12.5),
              child: Row(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title ?? "", style: const TextStyle(fontSize: 14, color: Colors.black)),
                    const SizedBox(height: 2),
                    Text(
                      subtitle1 ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 1),
                    SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey,
                        )),
                  ]),
                ],
              ),
            )),
      ),
    );
  }
}
