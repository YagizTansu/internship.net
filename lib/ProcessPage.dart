import 'package:flutter/material.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({Key? key}) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Applied',
                  ),
                  Tab(
                    text: 'Saved',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Applied")),
            Center(child: Text("Saved")),
          ],
        ),
      ),
    );
  }
}
