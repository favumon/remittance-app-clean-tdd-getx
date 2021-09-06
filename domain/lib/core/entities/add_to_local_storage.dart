import 'package:equatable/equatable.dart';

class AddToLocalStorage<T> extends Equatable {
  //final String key;
  final T value;

  AddToLocalStorage(this.value);

  @override
  List<Object?> get props => [value];
}
