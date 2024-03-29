import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_spec/blocs/iphone_bloc/iphone_bloc.dart';
import 'package:phone_spec/screens/iphone/iphone_version_detail.dart';
import 'package:phone_spec/screens/widgets/custom_cache_image.dart';
import 'package:phone_spec/utils/currency_format.dart';

enum StatusAd { initial, loaded }

class IphoneDashboard extends StatefulWidget {
  const IphoneDashboard({Key? key}) : super(key: key);

  @override
  _IphoneDashboardState createState() => _IphoneDashboardState();
}

class _IphoneDashboardState extends State<IphoneDashboard> {
  late IphoneBloc _iphoneBloc;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  /// Set default hasReachMax value false
  /// Variabel ini digunakan untuk menangani agaer scrollController tidak-
  /// Berlangsung terus menerus.
  bool _hasReachMax = false;

  BannerAd? myBanner;

  StatusAd statusAd = StatusAd.initial;

  BannerAdListener listener() => BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          if (kDebugMode) {
            print('Ad Loaded.');
          }
          setState(() {
            statusAd = StatusAd.loaded;
          });
        },
      );

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && !_hasReachMax) {
      if (kDebugMode) {
        print('iam scrolling');
      }
      _iphoneBloc.add(GetIphone(10, false, 14, _searchController.text));
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    _searchController.text = '';
    _iphoneBloc.add(GetIphone(10, true, 14, ''));
    if (kDebugMode) {
      print('Refresing...');
    }
  }

  @override
  void initState() {
    _iphoneBloc = BlocProvider.of<IphoneBloc>(context);
    _iphoneBloc.add(GetIphone(10, true, 14, ''));

    _scrollController.addListener(onScroll);

    myBanner = BannerAd(
      // test banner
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      //
      adUnitId: 'ca-app-pub-2465007971338713/2549938883',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: listener(),
    );
    myBanner!.load();
    super.initState();
  }

  @override
  void dispose() {
    myBanner!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<IphoneBloc, IphoneState>(
      listener: (context, state) {
        if (state is IphoneData) {
          _hasReachMax = state.hasReachMax;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
            backgroundColor: Colors.white,
            color: Colors.purple,
            displacement: 20,
            onRefresh: () => _refresh(),
            child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    floating: true,
                    title: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                offset: const Offset(0, 1),
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              controller: _searchController,
                              onSubmitted: (e) {
                                _iphoneBloc.add(GetIphone(18, true, 14, e));
                              },
                              textAlignVertical: TextAlignVertical.bottom,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    top: 6, bottom: 7, left: 10),
                                hintText: 'Cari versi Iphone...',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                _iphoneBloc.add(GetIphone(
                                    18, true, 14, _searchController.text));
                              },
                              icon: const Icon(Icons.search))
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Center(
                      child: statusAd == StatusAd.loaded
                          ? Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 15, right: 15),
                              alignment: Alignment.center,
                              child: AdWidget(ad: myBanner!),
                              width: myBanner!.size.width.toDouble(),
                              height: myBanner!.size.height.toDouble(),
                            )
                          : Container(),
                    ),
                  ])),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    BlocBuilder<IphoneBloc, IphoneState>(
                      builder: (context, state) {
                        if (state is IphoneData) {
                          if (state.listIphones.length != 0) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                itemCount: state.hasReachMax
                                    ? state.listIphones.length
                                    : state.listIphones.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < state.listIphones.length) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return IphoneVersionDetail(
                                              specificationModel:
                                                  state.listIphones[index],
                                            );
                                          }));
                                        },
                                        title: Text(
                                            state.listIphones[index].title ??
                                                ''),
                                        subtitle: Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.shopping_bag,
                                                  color: Colors.white,
                                                  size: 13,
                                                ))),
                                            Text(' ' +
                                                (state.listIphones[index]
                                                            .price !=
                                                        null
                                                    ? currencyId.format(
                                                        int.parse(state
                                                            .listIphones[index]
                                                            .price!))
                                                    : '')),
                                          ],
                                        ),
                                        leading: SizedBox(
                                          width: 50,
                                          child: CustomCacheImage.build(
                                            context,
                                            imgUrl: state.listIphones[index]
                                                    .images!.isNotEmpty
                                                ? state.listIphones[index]
                                                    .images![0]
                                                : 'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg',
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 15, right: 15),
                                      child: Center(
                                        child: SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: CircularProgressIndicator(
                                              color: Colors.purple,
                                              strokeWidth: 2),
                                        ),
                                      ),
                                    );
                                  }
                                });
                          } else {
                            return Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: size.height * 0.1),
                                    height: size.height * 0.3,
                                    width: size.width,
                                    child: Image.asset(
                                        'assets/images/no-record.png'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Upps, Iphone tidak ditemukan sob!')
                                ],
                              ),
                            );
                          }
                        } else {
                          return Container(
                            height: size.height * 0.6,
                            width: size.width,
                            child: Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                    color: Colors.purple, strokeWidth: 2),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ]))
                ])),
      ),
    );
  }
}
