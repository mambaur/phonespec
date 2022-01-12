import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AndroidVersionDetail extends StatefulWidget {
  const AndroidVersionDetail({Key? key}) : super(key: key);

  @override
  _AndroidVersionDetailState createState() => _AndroidVersionDetailState();
}

class _AndroidVersionDetailState extends State<AndroidVersionDetail> {
  final CarouselController _controller = CarouselController();
  // Index untuk indicator carousel
  int _currentCarrousel = 0;

  final List<String> imgList = [
    'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s21-fe-5g.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Samsung G1A 33'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.5,
              // decoration: BoxDecoration(color: Colors.white, boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey, offset: Offset(0, 1), blurRadius: 1)
              // ]),
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: size.height * 0.5,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarrousel = index;
                        });
                      },
                    ),
                    items: imgList
                        .map((item) => Container(
                              child: Container(
                                child: Image.network(item,
                                    fit: BoxFit.scaleDown, width: 1000.0),
                              ),
                            ))
                        .toList(),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _currentCarrousel == entry.key
                                              ? 0.9
                                              : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Range (Rp)',
                    value: '1.000.000 - 10.000.000',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Status',
                    value: 'Available',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Network',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Technology',
                    value: 'GSM/CDMA',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: '4G',
                    value: 'LTE',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Speed',
                    value: 'HSPA 34.4545 LTE A Cat 19 1600',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Launch',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Announced',
                    value: '2022, January 04',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Status',
                    value: 'Available',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Display',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Dimensions',
                    value: '155.7',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Weight',
                    value: '177 g (6.24 oz)',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Protection',
                    value: 'Corning Gorilla',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDetailAndroid extends StatelessWidget {
  const ItemDetailAndroid(
      {Key? key, required this.size, this.title, this.value})
      : super(key: key);

  final Size size;
  final String? title, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: size.width * 0.3,
              child: Text(
                title ?? '',
                style: TextStyle(color: Colors.grey),
              )),
          Expanded(child: Text(value ?? '')),
        ],
      ),
    );
  }
}
