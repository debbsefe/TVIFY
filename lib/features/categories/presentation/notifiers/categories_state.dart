import 'package:equatable/equatable.dart';
import '../../domain/entities/categories.dart';

abstract class CategoriesState extends Equatable {
  CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial();

  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading();

  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<Categories> categories;
  CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);

  @override
  List<Object> get props => [message];
}
