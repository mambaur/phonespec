import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:phone_spec/models/brand_model.dart';
import 'package:phone_spec/repositories/brand_repository.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepository _brandRepo = BrandRepository();
  List<BrandModel> listBrands = [];
  int page = 1;

  BrandBloc() : super(BrandInitial()) {
    on<GetBrand>(_getBrand);
  }

  Future _getBrand(GetBrand event, Emitter<BrandState> emit) async {
    try {
      if (event.isInit) {
        print('Get init brand detail ...');
        page = 1;
        emit(GetBrandLoading());
        List<BrandModel>? data = await _brandRepo.getBrands(
            page: page, limit: event.limit, q: event.q);
        if (data != null) {
          listBrands = data;
          data.length < event.limit
              ? emit(BrandData(listBrands, true))
              : emit(BrandData(listBrands, false));
        } else {
          emit(BrandData(listBrands, false));
        }
      } else {
        print('Get more brand detail ...');
        page++;
        List<BrandModel>? data = await _brandRepo.getBrands(
            page: page, limit: event.limit, q: event.q);
        if (data != null) {
          listBrands.addAll(data);
          data.length < event.limit
              ? emit(BrandData(listBrands, true))
              : emit(BrandData(listBrands, false));
        } else {
          emit(BrandData(listBrands, false));
        }
      }
    } catch (e) {
      emit(BrandError('Terjadi kesalahan, silahkan coba kembali'));
    }
  }
}
