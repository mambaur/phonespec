part of 'brand_bloc.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}

class GetBrandLoading extends BrandState {}

class BrandData extends BrandState {
  final List<BrandModel> listBrands;
  final bool hasReachMax;
  BrandData(this.listBrands, this.hasReachMax);
}

class BrandSuccess extends BrandState {
  final String message;
  BrandSuccess(this.message);
}

class BrandError extends BrandState {
  final String message;
  BrandError(this.message);
}
