part of 'iphone_bloc.dart';

@immutable
abstract class IphoneState {}

class IphoneInitial extends IphoneState {}

class GetIphoneLoading extends IphoneState {}

class IphoneData extends IphoneState {
  final List<SpecificationModel> listIphones;
  final bool hasReachMax;
  IphoneData(this.listIphones, this.hasReachMax);
}

class IphoneSuccess extends IphoneState {
  final String message;
  IphoneSuccess(this.message);
}

class IphoneError extends IphoneState {
  final String message;
  IphoneError(this.message);
}
