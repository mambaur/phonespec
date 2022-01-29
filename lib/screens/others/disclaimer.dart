import 'package:flutter/material.dart';

class Disclaimer extends StatefulWidget {
  const Disclaimer({Key? key}) : super(key: key);

  @override
  _DisclaimerState createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disclaimer',
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //     child: SizedBox(
              //         width: 150,
              //         child: Image.asset('assets/images/icon_recipe.png'))),
              SizedBox(
                height: 15,
              ),
              const Text(
                  'Phonespec adalah aplikasi yang dapat membantu anda memberikan informasi lengkap spesifikasi smartphone yang ingin anda cari.'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                  'Namun kami tidak dapat menjamin bahwa informasi di aplikasi ini 100% benar, anda dapat memvalidasinya dengan mengunjungi website resmi dari smartphone terkait secara langsung.'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                  'Kami akan selalu berusaha memberikan informasi terupdate mengenai spesifikasi smartphone.'),
              const SizedBox(
                height: 15,
              ),
            ],
          )),
    );
  }
}
