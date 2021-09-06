import 'package:equatable/equatable.dart';

class RetrieveFromLocalStorage<T> extends Equatable {
  final T value;

  RetrieveFromLocalStorage(this.value);

  @override
  List<Object?> get props => [value];
}
