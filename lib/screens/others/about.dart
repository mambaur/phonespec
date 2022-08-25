import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: SizedBox(
                      width: 170,
                      child: Image.asset('assets/images/phonespec.png'))),
              SizedBox(
                height: 15,
              ),
              const Text(
                  'Phonespec adalah aplikasi yang dapat membantu anda memberikan informasi lengkap mengenai spesifikasi smartphone. Informasi tersedia secara lengkap dan terupdate. Kamu dapat melihat harga, versi, dan beberapa fitur yang terdapat pada suatu smartphone.'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                  'Pada aplikasi ini terdapat beberapa brand kesukaan anda, dimana setiap brand memiliki versi dan peluncuran smartphone terbaru yang dapat anda lihat. Selain android, kamu juga dapat melihat informasi spesifikasi pada Iphone secara detail.'),
              const SizedBox(
                height: 15,
              ),
              const Text('Sumber Referensi : '),
              GestureDetector(
                onTap: () {
                  _launchURL('https://www.gsmarena.com/');
                },
                child: const Text(
                  'www.gsmarena.com ',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          )),
    );
  }
}
