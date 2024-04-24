import 'package:equatable/equatable.dart';

class ListResponseBaseEntity extends Equatable {
  final int count;
  final String? next;
  final String? previous;

  const ListResponseBaseEntity({required this.count, this.next, this.previous});
  @override
  List<Object?> get props => [count, next, previous];
}
