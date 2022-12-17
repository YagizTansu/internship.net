import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship/Settings.dart';

class Intern {
  Intern(
      {required this.companyName,
      required this.jobTitle,
      required this.location,
      required this.publishDay});

  final String companyName;
  final String jobTitle;
  final String location;
  final String publishDay;

  Intern.fromJson(Map<String, dynamic> m)
      : this(
            companyName: m['companyName'],
            jobTitle: m['author'],
            location: m['numPages'],
            publishDay: m['numPages']);
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('interns');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "INTERNSHIP.NET",
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w900),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: _products.snapshots(), //build connection
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //number of rows
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return InternCard(intern: documentSnapshot);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

/*Center(
          child: ListView(
            children: jobs.map((e) => InternCard(intern: e)).toList(),
          ),
        ),
*/

class InternCard extends StatelessWidget {
  const InternCard({Key? key, required this.intern}) : super(key: key);

  final DocumentSnapshot intern;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InternDetailPage(
                        intern: intern,
                      )));
            },
            child: Card(
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      "images/logo.png",
                      height: 80,
                    ),
                    title: Text(
                      intern["companyName"] + " - " + intern["jobTitle"],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(intern["location"]),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.double_arrow_outlined,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text('Actively recruiting'),
                            ],
                          ),
                        ),
                        Text(
                          intern["publishDay"] + " ago",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.add_box),
                    isThreeLine: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InternDetailPage extends StatefulWidget {
  const InternDetailPage({Key? key, required this.intern}) : super(key: key);
  final DocumentSnapshot intern;

  @override
  State<InternDetailPage> createState() => _InternDetailPageState();
}

class _InternDetailPageState extends State<InternDetailPage> {
  final CollectionReference saved =
      FirebaseFirestore.instance.collection('saved');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 2,
              child: Container(
                child: Image.asset("images/logo.png"),
              )),
          Flexible(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                widget.intern["companyName"] +
                                    " - " +
                                    widget.intern["jobTitle"],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_box),
                                tooltip: 'Increase volume by 10',
                                onPressed: () {
                                  setState(() {
                                    Map<String, dynamic> savedIntern = {
                                      'jobTitle': widget.intern["jobTitle"],
                                      'location': widget.intern["location"],
                                      'companyName':
                                          widget.intern["companyName"],
                                      'publishDay': widget.intern["publishDay"]
                                    };
                                    saved.add(savedIntern);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.intern["publishDay"] + " ago",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(
                            "Description",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Facilisi cras fermentum odio eu. Commodo quis imperdiet massa tincidunt nunc pulvinar. Adipiscing at in tellus integer feugiat scelerisque varius morbi enim. Suscipit adipiscing bibendum est ultricies. Quam vulputate dignissim suspendisse in est ante in nibh mauris. Accumsan sit amet nulla facilisi morbi tempus iaculis urna. Ut aliquam purus sit amet luctus venenatis lectus magna fringilla. Eget felis eget nunc lobortis mattis. Elementum facilisis leo vel fringilla est ullamcorper eget. Auctor elit sed vulputate mi. Vel facilisis volutpat est velit egestas dui id ornare. Ipsum dolor sit amet consectetur adipiscing elit."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Text(
                            "Responsiblities",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("egestas fringilla"),
                              Text("morbi non arcu risus"),
                              Text("scelerisque fermentum dui faucibus in"),
                              Text("C++"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
