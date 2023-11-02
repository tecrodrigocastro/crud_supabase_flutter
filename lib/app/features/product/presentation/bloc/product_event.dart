// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProductEvent {
  final AddProductUseCase addProductUseCase;
  const AddProductEvent({
    required this.addProductUseCase,
  });
}

class DeleteProductEvent extends ProductEvent {
  final ProductEntity product;
  const DeleteProductEvent({
    required this.product,
  });
}

class ProductInitialState extends ProductEvent {}
