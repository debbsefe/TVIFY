import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  const Categories({this.id, this.name});

  final int? id;
  final String? name;

  @override
  List<Object?> get props => [id, name];
}
