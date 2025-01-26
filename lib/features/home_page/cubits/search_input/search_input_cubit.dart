import 'package:bloc/bloc.dart';

class SearchInputCubit extends Cubit<String> {
  SearchInputCubit() : super('');

  void setNewValue(String newValue) {
    emit(newValue);
  }
}
