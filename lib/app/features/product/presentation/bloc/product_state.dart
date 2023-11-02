// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAddSucces extends ProductState {
  final String? message;
  const ProductAddSucces({
    this.message,
  });
}

class ProductDelete extends ProductState {}

class ProductAddError extends ProductState {
  final String? error;
  const ProductAddError({
    this.error,
  });
}
