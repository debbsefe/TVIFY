import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  const Categories({required this.id, required this.name});

  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
