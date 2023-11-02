import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_crud_app/app/features/dashboard/domain/entities/product_entity.dart';
import 'package:supabase_crud_app/app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:supabase_crud_app/app/features/product/domain/repositories/product_repository.dart';
import 'package:supabase_crud_app/app/features/product/domain/usecases/add_product_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final ProductRepository repository = ProductRepository();
    final DashboardBloc bloc = DashboardBloc();
    on<AddProductEvent>((event, emit) async {
      emit(ProductLoading());
      Timer(const Duration(seconds: 3), () async {
        await repository.addProduct(event.addProductUseCase);
      });
      emit(const ProductAddSucces(message: 'Produto cadastrado com sucesso!'));
    });
    on<ProductInitialState>((event, emit) {
      emit(ProductInitial());
    });

    on<DeleteProductEvent>((event, emit) {
      emit(ProductLoading());
      Timer(const Duration(seconds: 3), () async {
        await repository.deleteProduct(event.product);
        bloc.add(FetchAllProducts());
      });
      emit(ProductDelete());
    });
  }
}
