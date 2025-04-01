import 'package:equatable/equatable.dart';
import '../models/diamond.dart';

abstract class DiamondState extends Equatable {}

class DiamondInitial extends DiamondState {
  @override
  List<Object> get props => [];
}

class DiamondLoading extends DiamondState {
  @override
  List<Object> get props => [];
}

class DiamondLoaded extends DiamondState {
  final List<Diamond> diamonds;

  DiamondLoaded({required this.diamonds});

  @override
  List<Object> get props => [diamonds];
}

class DiamondError extends DiamondState {
  final String message;

  DiamondError({required this.message});

  @override
  List<Object> get props => [message];
}