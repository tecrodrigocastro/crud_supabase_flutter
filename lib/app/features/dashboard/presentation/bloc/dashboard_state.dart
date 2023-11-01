// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<ProductEntity> products;
  const DashboardLoaded({
    required this.products,
  });
}

class DashboardError extends DashboardState {
  final String? error;
  const DashboardError({required this.error});
}
