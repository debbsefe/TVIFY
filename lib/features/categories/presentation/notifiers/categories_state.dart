import 'package:equatable/equatable.dart';
import '../../domain/entities/categories.dart';

abstract class CategoriesState extends Equatable {}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded(this.categories);

  final List<Categories> categories;

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  CategoriesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
