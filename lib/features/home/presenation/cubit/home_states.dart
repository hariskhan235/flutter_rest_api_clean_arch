import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final dynamic data;

  const HomeSuccess({required this.data});
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure({required this.message});
}
