import 'package:flutter/material.dart';

class AddToQueueScreen extends StatefulWidget {
  const AddToQueueScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AddToQueueScreen> createState() => _AddToQueueScreenState();
}

class _AddToQueueScreenState extends State<AddToQueueScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}
