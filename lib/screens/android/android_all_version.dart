import 'package:flutter/material.dart';
import 'package:phone_spec/screens/android/android_version_detail.dart';

class AndroidAllVersion extends StatefulWidget {
  const AndroidAllVersion({Key? key}) : super(key: key);

  @override
  _AndroidAllVersionState createState() => _AndroidAllVersionState();
}

class _AndroidAllVersionState extends State<AndroidAllVersion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Samsung'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 15),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AndroidVersionDetail();
                }));
              },
              title: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.white,
                    child: Image.network(
                        'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Samsung 1.3'),
                      Text(
                        'Versi terbaru',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  )),
                ],
              ),
              // leading: Container(
              //   height: 100,
              //   width: 100,
              //   color: Colors.grey,
              // ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 10,
              thickness: 0.5,
            );
          },
          itemCount: 17),
    );
  }
}
