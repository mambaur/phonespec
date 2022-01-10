import 'package:flutter/material.dart';
import 'package:phone_spec/screens/android/android_all_version.dart';

class AndroidDashboard extends StatefulWidget {
  const AndroidDashboard({Key? key}) : super(key: key);

  @override
  _AndroidDashboardState createState() => _AndroidDashboardState();
}

class _AndroidDashboardState extends State<AndroidDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(15),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1 / 1.3,
        crossAxisCount: 3,
        children: List.generate(15, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AndroidAllVersion();
              }));
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Expanded(
                      child: Center(
                          child: Image.network(
                              'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg'))),
                  Center(
                      child: const Text(
                    "Samsung",
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
              // color: Colors.teal[100],
            ),
          );
        }),
        // children: <Widget>[
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text("He'd have you all unravel at the"),
        //     color: Colors.teal[100],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Heed not the rabble'),
        //     color: Colors.teal[200],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Sound of screams but the'),
        //     color: Colors.teal[300],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Who scream'),
        //     color: Colors.teal[400],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Revolution is coming...'),
        //     color: Colors.teal[500],
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     child: const Text('Revolution, they...'),
        //     color: Colors.teal[600],
        //   ),
        // ],
      ),
    );
  }
}
