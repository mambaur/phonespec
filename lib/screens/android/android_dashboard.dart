import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:phone_spec/blocs/brand_bloc/brand_bloc.dart';
import 'package:phone_spec/screens/android/android_all_version.dart';
import 'package:phone_spec/screens/widgets/custom_cache_image.dart';

enum StatusAd { initial, loaded }

class AndroidDashboard extends StatefulWidget {
  const AndroidDashboard({Key? key}) : super(key: key);

  @override
  _AndroidDashboardState createState() => _AndroidDashboardState();
}

class _AndroidDashboardState extends State<AndroidDashboard> {
  late BrandBloc _brandBloc;
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

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
      print('iam scrolling');
      _brandBloc.add(GetBrand(18, false, _searchController.text));
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    _searchController.text = '';
    _brandBloc.add(GetBrand(18, true, ''));
    print('Refresing...');
  }

  @override
  void initState() {
    _brandBloc = BlocProvider.of<BrandBloc>(context);
    _brandBloc.add(GetBrand(18, true, ''));

    _scrollController.addListener(onScroll);

    myBanner = BannerAd(
      // test banner
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      //
      adUnitId: 'ca-app-pub-2465007971338713/2900622168',
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
    return BlocListener<BrandBloc, BrandState>(
      listener: (context, state) {
        if (state is BrandData) {
          _hasReachMax = state.hasReachMax;
        }
      },
      child: Scaffold(
        body: RefreshIndicator(
          backgroundColor: Colors.white,
          color: Colors.purple,
          displacement: 20,
          onRefresh: () => _refresh(),
          child: CustomScrollView(
              controller: _scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0, 1),
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
                              _brandBloc.add(GetBrand(18, true, e));
                            },
                            textAlignVertical: TextAlignVertical.bottom,
                            maxLines: 1,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.only(top: 6, bottom: 7, left: 10),
                              hintText: 'Cari brand favoritmu...',
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
                              _brandBloc.add(
                                  GetBrand(18, true, _searchController.text));
                            },
                            icon: Icon(Icons.search))
                      ],
                    ),
                  ),
                ])),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Center(
                    child: statusAd == StatusAd.loaded
                        ? Container(
                            margin:
                                EdgeInsets.only(top: 15, left: 15, right: 15),
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
                  BlocBuilder<BrandBloc, BrandState>(
                    builder: (context, state) {
                      if (state is BrandData) {
                        if (state.listBrands.length != 0) {
                          return GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(15),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / 1.3,
                            crossAxisCount: 3,
                            children: List.generate(
                                state.hasReachMax
                                    ? state.listBrands.length
                                    : state.listBrands.length % 3 == 0
                                        ? state.listBrands.length + 3
                                        : state.listBrands.length % 2 == 0
                                            ? state.listBrands.length + 2
                                            : state.listBrands.length + 1,
                                (index) {
                              if (index < state.listBrands.length) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AndroidAllVersion(
                                        brandModel: state.listBrands[index],
                                      );
                                    }));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 7,
                                            offset: Offset(1, 3),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: CustomCacheImage.build(
                                          context,
                                          imgUrl: state
                                                  .listBrands[index].images ??
                                              'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg',
                                        )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                            child: Text(
                                          state.listBrands[index].name ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ],
                                    ),
                                    // color: Colors.teal[100],
                                  ),
                                );
                              } else {
                                // return Center(
                                //   child: SizedBox(
                                //     width: 30,
                                //     height: 30,
                                //     child: CircularProgressIndicator(
                                //         color: Colors.orange.shade600,
                                //         strokeWidth: 2),
                                //   ),
                                // );
                                return Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.purple.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                );
                              }
                            }),
                          );
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
                                Text('Upps, brand tidak ditemukan sob!')
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
              ]),
        ),
      ),
    );
  }
}
