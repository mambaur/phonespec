part of 'specification_bloc.dart';

@immutable
abstract class SpecificationEvent {}

class GetSpecification extends SpecificationEvent {
  final int limit, brandId;
  final bool isInit;
  final String q;
  GetSpecification(this.limit, this.isInit, this.brandId, this.q);
}
