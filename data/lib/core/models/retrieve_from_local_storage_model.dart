import 'package:domain/core/entities/retrieve_from_local_storage.dart';

class RetrieveFromLocalStorageModel<T> extends RetrieveFromLocalStorage<T> {
  final T value;

  RetrieveFromLocalStorageModel(this.value) : super(value);
}
