import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var jobs = [
    "Senior Developer",
    "Junior Developer",
    "Backend Developer",
    "Frontend Developer"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Internship.net",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            JobCard(),
            JobCard(),
            JobCard(),
            JobCard(),
            JobCard(),
            JobCard(),
            JobCard(),
            JobCard(),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatefulWidget {
  const JobCard({
    Key? key,
  }) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: Column(
              children: [
                ListTile(
                  leading: FlutterLogo(size: 70.0),
                  title: Text(
                    'Senior Developer ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('İzmir, Turkey'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.double_arrow_outlined,color: Colors.green,),
                            SizedBox(
                              width: 12,
                            ),
                            Text('Aktif olarak işe alım yapıyor'),
                          ],
                        ),
                      ),
                      Text(
                        '1 hafta önce',
                        style: TextStyle(color: Colors.green,
                        fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  trailing: Icon(Icons.add_box),
                  isThreeLine: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
