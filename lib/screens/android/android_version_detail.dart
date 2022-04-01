import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:phone_spec/models/specifications_model.dart';
import 'package:phone_spec/utils/currency_format.dart';

class AndroidVersionDetail extends StatefulWidget {
  final SpecificationModel specificationModel;
  const AndroidVersionDetail({Key? key, required this.specificationModel})
      : super(key: key);

  @override
  _AndroidVersionDetailState createState() => _AndroidVersionDetailState();
}

class _AndroidVersionDetailState extends State<AndroidVersionDetail> {
  final CarouselController _controller = CarouselController();
  // Index untuk indicator carousel
  int _currentCarrousel = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.specificationModel.title ?? '-'),
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
                    items: widget.specificationModel.images!
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
                        children: widget.specificationModel.images!
                            .asMap()
                            .entries
                            .map((entry) {
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
                    'Launch',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Price (Rp)',
                    value: '± ' +
                        (widget.specificationModel.price != null
                            ? currencyId.format(
                                int.parse(widget.specificationModel.price!))
                            : '-'),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Status',
                    value: widget.specificationModel.status ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Announced',
                    value: widget.specificationModel.announced ?? '-',
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
                    value: widget.specificationModel.technology ?? '-',
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
                    'Body',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Dimensions',
                    value: widget.specificationModel.dimensions ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Weight',
                    value: widget.specificationModel.weight ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Build',
                    value: widget.specificationModel.build ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'SIM',
                    value: widget.specificationModel.sim ?? '-',
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
                    title: 'Type',
                    value: widget.specificationModel.typeDisplay ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Size',
                    value: widget.specificationModel.size ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Resolution',
                    value: widget.specificationModel.resolution ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Protection',
                    value: widget.specificationModel.protection ?? '-',
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
                    'Platform',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'OS',
                    value: widget.specificationModel.os ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Chipset',
                    value: widget.specificationModel.chipset ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'CPU',
                    value: widget.specificationModel.cpu ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'GPU',
                    value: widget.specificationModel.gpu ?? '-',
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
                    'Memory',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Card Slot',
                    value: widget.specificationModel.cardSlot ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Internal',
                    value: widget.specificationModel.internal ?? '-',
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
                    'Main Camera',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: widget.specificationModel.triple != null
                        ? 'Triple'
                        : widget.specificationModel.quad != null
                            ? 'Quad'
                            : widget.specificationModel.single != null
                                ? 'Single'
                                : 'Triple',
                    value: widget.specificationModel.triple != null
                        ? widget.specificationModel.triple!
                        : widget.specificationModel.quad != null
                            ? widget.specificationModel.quad!
                            : widget.specificationModel.single != null
                                ? widget.specificationModel.single!
                                : '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Features',
                    value: widget.specificationModel.features ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Video',
                    value: widget.specificationModel.video ?? '-',
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
                    'Selfie Camera',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: widget.specificationModel.scSingle != null
                        ? 'Single'
                        : widget.specificationModel.scDual != null
                            ? 'Dual'
                            : 'Single',
                    value: widget.specificationModel.scSingle != null
                        ? widget.specificationModel.scSingle!
                        : widget.specificationModel.scDual != null
                            ? widget.specificationModel.scDual!
                            : '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Features',
                    value: widget.specificationModel.scFeatures ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Video',
                    value: widget.specificationModel.scVideo ?? '-',
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
                    'Sound',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Loudspeaker',
                    value: widget.specificationModel.loudSpeakerSound ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: '3.5mm jack',
                    value: widget.specificationModel.jack ?? '-',
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
                    'Comms',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Wlan',
                    value: widget.specificationModel.wlan ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Bluetooth',
                    value: widget.specificationModel.bluetooth ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'GPS',
                    value: widget.specificationModel.gps ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'NFT',
                    value: widget.specificationModel.nfc ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Radio',
                    value: widget.specificationModel.radio ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'USB',
                    value: widget.specificationModel.usb ?? '-',
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
                    'Features',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Sensors',
                    value: widget.specificationModel.sensors ?? '-',
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
                    'Battery',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Type',
                    value: widget.specificationModel.typeBattery ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Charging',
                    value: widget.specificationModel.charging ?? '-',
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
                    'Misc',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Colors',
                    value: widget.specificationModel.colors ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Models',
                    value: widget.specificationModel.models ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'SAR',
                    value: widget.specificationModel.sar ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'SAR EU',
                    value: widget.specificationModel.sarEU ?? '-',
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
                    'Tests',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Performance',
                    value: widget.specificationModel.performanceTest ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Display',
                    value: widget.specificationModel.displayTest ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Loudspeaker',
                    value: widget.specificationModel.loudSpeakerTest ?? '-',
                  ),
                  ItemDetailAndroid(
                    size: size,
                    title: 'Battery Life',
                    value: widget.specificationModel.batteryLife ?? '-',
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
                title ?? '-',
                style: TextStyle(color: Colors.grey),
              )),
          Expanded(child: Text(value ?? '-')),
        ],
      ),
    );
  }
}
