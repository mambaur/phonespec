part of 'iphone_bloc.dart';

@immutable
abstract class IphoneEvent {}

class GetIphone extends IphoneEvent {
  final int limit, brandId;
  final bool isInit;
  final String q;
  GetIphone(this.limit, this.isInit, this.brandId, this.q);
}
