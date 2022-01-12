import 'package:flutter/material.dart';
import 'package:phone_spec/screens/iphone/iphone_version_detail.dart';

class IphoneDashboard extends StatefulWidget {
  const IphoneDashboard({Key? key}) : super(key: key);

  @override
  _IphoneDashboardState createState() => _IphoneDashboardState();
}

class _IphoneDashboardState extends State<IphoneDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Card(
        elevation: 1,
        shadowColor: Colors.grey,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.grey.shade300,
                          blurRadius: 2)
                    ]),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const IphoneVersionDetail();
                    }));
                  },
                  title: Text('Iphone 10'),
                  subtitle: Text('Sub Version 10'),
                  leading: Image.network(
                      'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg'),
                ),
              );
            }),
      ),
    );
  }
}
