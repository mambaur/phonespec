import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phone_spec/models/specifications_model.dart';
import 'package:phone_spec/repositories/specification_repository.dart';

part 'specification_event.dart';
part 'specification_state.dart';

class SpecificationBloc extends Bloc<SpecificationEvent, SpecificationState> {
  final SpecificationRepository _specificationRepo = SpecificationRepository();
  List<SpecificationModel> listSpecifications = [];
  int page = 1;
  SpecificationBloc() : super(SpecificationInitial()) {
    on<GetSpecification>(_getSpecification);
  }

  Future _getSpecification(
      GetSpecification event, Emitter<SpecificationState> emit) async {
    try {
      if (event.isInit) {
        print('Get init specification phone detail ...');
        page = 1;
        emit(GetSpecificationLoading());
        List<SpecificationModel>? data = await _specificationRepo
            .getSpecifications(event.brandId, event.q, page, event.limit);
        if (data != null) {
          listSpecifications = data;
          data.length < event.limit
              ? emit(SpecificationData(listSpecifications, true))
              : emit(SpecificationData(listSpecifications, false));
        } else {
          emit(SpecificationData(listSpecifications, false));
        }
      } else {
        print('Get more specification phone detail ...');
        page++;
        List<SpecificationModel>? data = await _specificationRepo
            .getSpecifications(event.brandId, event.q, page, event.limit);
        if (data != null) {
          listSpecifications.addAll(data);
          data.length < event.limit
              ? emit(SpecificationData(listSpecifications, true))
              : emit(SpecificationData(listSpecifications, false));
        } else {
          emit(SpecificationData(listSpecifications, false));
        }
      }
    } catch (e) {
      emit(SpecificationError('Terjadi kesalahan, silahkan coba kembali'));
    }
  }
}
