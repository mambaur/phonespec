part of 'brand_bloc.dart';

@immutable
abstract class BrandEvent {}

class GetBrand extends BrandEvent {
  final int limit;
  final bool isInit;
  final String q;
  GetBrand(this.limit, this.isInit, this.q);
}
