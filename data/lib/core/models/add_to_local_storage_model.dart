import 'package:domain/core/entities/add_to_local_storage.dart';

class AddToLocalStorageModel<T> extends AddToLocalStorage<T> {
  final T value;

  AddToLocalStorageModel(this.value) : super(value);
}
