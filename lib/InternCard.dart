import 'package:flutter/material.dart';
import 'package:internship/models/Intern.dart';
import 'InternDetailPage.dart';

class InternCard extends StatelessWidget {
  const InternCard({Key? key, required this.intern}) : super(key: key);
  final Intern intern;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        children: [
          GestureDetector(
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
                      intern.companyName+ " - " + intern.jobTitle,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(intern.location),
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
                          intern.publishDay + " ago",
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
