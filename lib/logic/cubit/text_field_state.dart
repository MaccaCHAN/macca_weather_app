part of 'text_field_cubit_test.dart';

@immutable
class TextFieldState extends Equatable{
  final String inputText;
  const TextFieldState({required this.inputText});

  @override
  List<Object?> get props => [inputText];
}

