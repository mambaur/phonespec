import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_spec/blocs/specification_bloc/specification_bloc.dart';
import 'package:phone_spec/models/brand_model.dart';
import 'package:phone_spec/screens/android/android_version_detail.dart';
import 'package:phone_spec/screens/widgets/custom_cache_image.dart';
import 'package:phone_spec/utils/currency_format.dart';

class AndroidAllVersion extends StatefulWidget {
  final BrandModel brandModel;
  const AndroidAllVersion({Key? key, required this.brandModel})
      : super(key: key);

  @override
  _AndroidAllVersionState createState() => _AndroidAllVersionState();
}

class _AndroidAllVersionState extends State<AndroidAllVersion> {
  late SpecificationBloc _specificationBloc;
  ScrollController _scrollController = ScrollController();
  TextEditingController _searchController = TextEditingController();

  /// Set default hasReachMax value false
  /// Variabel ini digunakan untuk menangani agaer scrollController tidak-
  /// Berlangsung terus menerus.
  bool _hasReachMax = false;

  void onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;

    if (currentScroll == maxScroll && !_hasReachMax) {
      print('iam scrolling');
      _specificationBloc.add(GetSpecification(
          18, false, widget.brandModel.id!, _searchController.text));
    }
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    _searchController.text = '';
    _specificationBloc
        .add(GetSpecification(18, true, widget.brandModel.id!, ''));
    print('Refresing...');
  }

  @override
  void initState() {
    _specificationBloc = BlocProvider.of<SpecificationBloc>(context);
    _specificationBloc
        .add(GetSpecification(18, true, widget.brandModel.id!, ''));

    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<SpecificationBloc, SpecificationState>(
      listener: (context, state) {
        if (state is SpecificationData) {
          _hasReachMax = state.hasReachMax;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.brandModel.name ?? ''),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
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
                      height: 40,
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
                                _specificationBloc.add(GetSpecification(
                                    18, true, widget.brandModel.id!, e));
                              },
                              textAlignVertical: TextAlignVertical.bottom,
                              maxLines: 1,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    top: 6, bottom: 7, left: 10),
                                hintText:
                                    'Cari versi ${widget.brandModel.name}...',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                // suffixIcon: Icon(
                                //   Icons.search,
                                //   size: 30,
                                //   color: Colors.grey,
                                // )
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                _specificationBloc.add(GetSpecification(
                                    18,
                                    true,
                                    widget.brandModel.id!,
                                    _searchController.text));
                              },
                              icon: Icon(Icons.search))
                        ],
                      ),
                    ),
                  ])),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    BlocBuilder<SpecificationBloc, SpecificationState>(
                      builder: (context, state) {
                        if (state is SpecificationData) {
                          if (state.listSpecifications.length != 0) {
                            return ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                itemBuilder: (context, index) {
                                  if (index < state.listSpecifications.length) {
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AndroidVersionDetail(
                                            specificationModel:
                                                state.listSpecifications[index],
                                          );
                                        }));
                                      },
                                      title: Row(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              color: Colors.white,
                                              child: CustomCacheImage.build(
                                                context,
                                                // borderRadius:
                                                //     BorderRadius.circular(10),
                                                imgUrl: state
                                                        .listSpecifications[
                                                            index]
                                                        .images!
                                                        .isNotEmpty
                                                    ? state
                                                        .listSpecifications[
                                                            index]
                                                        .images![0]
                                                    : 'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg',
                                              )
                                              // child: Image.network(
                                              //     'https://www.yahoomobile.com.pk/wp-content/uploads/2020/01/Infinix-Smart-3-price-in-Pakistan.jpg'),
                                              ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(state
                                                      .listSpecifications[index]
                                                      .title ??
                                                  ''),
                                              Text(
                                                '± ' +
                                                    (state
                                                                .listSpecifications[
                                                                    index]
                                                                .price !=
                                                            null
                                                        ? currencyId.format(
                                                            int.parse(state
                                                                .listSpecifications[
                                                                    index]
                                                                .price!))
                                                        : ''),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
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
                                  } else {
                                    return Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                            color: Colors.orange.shade600,
                                            strokeWidth: 2),
                                      ),
                                    );
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 10,
                                    thickness: 0.5,
                                  );
                                },
                                itemCount: state.hasReachMax
                                    ? state.listSpecifications.length
                                    : state.listSpecifications.length + 1);
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
                                  Text('Upps, versi tidak ditemukan sob!')
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
