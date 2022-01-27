part of 'specification_bloc.dart';

@immutable
abstract class SpecificationState {}

class SpecificationInitial extends SpecificationState {}

class GetSpecificationLoading extends SpecificationState {}

class SpecificationData extends SpecificationState {
  final List<SpecificationModel> listSpecifications;
  final bool hasReachMax;
  SpecificationData(this.listSpecifications, this.hasReachMax);
}

class SpecificationSuccess extends SpecificationState {
  final String message;
  SpecificationSuccess(this.message);
}

class SpecificationError extends SpecificationState {
  final String message;
  SpecificationError(this.message);
}
