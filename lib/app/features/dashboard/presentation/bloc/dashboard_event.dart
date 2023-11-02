// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class FetchAllProducts extends DashboardEvent {}

class RemoveProduct extends DashboardEvent {
  final ProductEntity product;
  const RemoveProduct({
    required this.product,
  });
}
