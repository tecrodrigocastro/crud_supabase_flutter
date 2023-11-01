import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/entities/product_entity.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/repositories/product_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    final ProductRepository repository = ProductRepository();
    on<FetchAllProducts>((event, emit) async {
      emit(DashboardLoading());
      final products = await repository.fetchAllProducts();
      emit(DashboardLoaded(products: products));
    });
  }
}
