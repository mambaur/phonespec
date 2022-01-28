import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phone_spec/models/specifications_model.dart';
import 'package:phone_spec/repositories/specification_repository.dart';

part 'iphone_event.dart';
part 'iphone_state.dart';

class IphoneBloc extends Bloc<IphoneEvent, IphoneState> {
  final SpecificationRepository _specificationRepo = SpecificationRepository();
  List<SpecificationModel> listIphones = [];
  int page = 1;

  IphoneBloc() : super(IphoneInitial()) {
    on<GetIphone>(_getIphone);
  }

  Future _getIphone(GetIphone event, Emitter<IphoneState> emit) async {
    try {
      if (event.isInit) {
        print('Get init iphone phone detail ...');
        page = 1;
        emit(GetIphoneLoading());
        List<SpecificationModel>? data = await _specificationRepo
            .getSpecifications(14, event.q, page, event.limit);
        if (data != null) {
          listIphones = data;
          data.length < event.limit
              ? emit(IphoneData(listIphones, true))
              : emit(IphoneData(listIphones, false));
        } else {
          emit(IphoneData(listIphones, false));
        }
      } else {
        print('Get more iphone phone detail ...');
        page++;
        List<SpecificationModel>? data = await _specificationRepo
            .getSpecifications(14, event.q, page, event.limit);
        if (data != null) {
          listIphones.addAll(data);
          data.length < event.limit
              ? emit(IphoneData(listIphones, true))
              : emit(IphoneData(listIphones, false));
        } else {
          emit(IphoneData(listIphones, false));
        }
      }
    } catch (e) {
      emit(IphoneError('Terjadi kesalahan, silahkan coba kembali'));
    }
  }
}
