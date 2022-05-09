import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wam_streams/screens/add_to_queue_screen.dart';
import 'package:wam_streams/screens/process_list_screen.dart';
import 'package:wam_streams/view_models/process_queue_view_model.dart';

class TabViewScreen extends StatefulWidget {
  const TabViewScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ProcessQueueViewModel())],
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Process Queue",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  bottom: const TabBar(
                    labelPadding: EdgeInsets.all(0),
                    unselectedLabelColor: Color.fromRGBO(200, 199, 204, 1),
                    tabs: [
                      CustomTab(
                        label: "Add",
                      ),
                      CustomTab(
                        label: "Queue",
                      ),
                    ],
                  ),
                ),
                body: const TabBarView(children: [AddToQueueScreen(), ProcessListScreen()]))));
  }
}

class CustomTab extends StatelessWidget {
  final String label;
  const CustomTab({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Theme.of(context).dividerColor),
        ),
      ),
      child: Tab(
        text: label,
      ),
    );
  }
}
