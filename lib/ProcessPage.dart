import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';

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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "INTERNSHIP.NET",
              style: TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.w900),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Applied',
                ),
                Tab(
                  text: 'Saved',
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SettingsPage()));
                },
              )
            ],
          ),
          body: TabBarView(
            children: [
              Center(child: Text("Applied")),
              Center(child: Text("Saved")),
            ],
          ),
        ),
      ),
    );
  }
}
