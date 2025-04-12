import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {
  final String id;

  const BaseEntity(this.id);

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [id];
}