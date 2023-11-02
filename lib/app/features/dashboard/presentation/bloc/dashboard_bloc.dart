import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/entities/product_entity.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    final DashboardRepository repository = DashboardRepository();
    var products = <ProductEntity>[];
    on<FetchAllProducts>((event, emit) async {
      emit(DashboardLoading());
      products = await repository.fetchAllProducts();
      emit(DashboardLoaded(products: products));
    });

    on<RemoveProduct>((event, emit) {
      products.remove(event.product);
      emit(DashboardLoaded(products: products));
    });
  }
}
