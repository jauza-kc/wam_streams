import 'package:flutter/material.dart';

class ProcessListScreen extends StatefulWidget {
  const ProcessListScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ProcessListScreen> createState() => _ProcessListScreenState();
}

class _ProcessListScreenState extends State<ProcessListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
