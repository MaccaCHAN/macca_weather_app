import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'text_field_state.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  TextFieldCubit() : super(const TextFieldState(inputText: ''));


  void textChange(String newText) {
    String newTextNoSpace = newText.replaceAll(' ', '');
    if (kDebugMode) {
      print(newTextNoSpace);
    }
    emit(TextFieldState(inputText: newTextNoSpace));
  }
}



