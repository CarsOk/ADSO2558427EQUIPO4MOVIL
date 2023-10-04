import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'form_validator_state.dart';

class FormValidatorCubit extends Cubit<FormValidatorState> {
  FormValidatorCubit() : super(FormValidatorState());

  void validateFields({
    required String title,
    required String name,
    required String subject,
    required String email,
    required String code,
  }) {
    print("entre al cubit");
    final isFormValid =
        title.isNotEmpty &&
        name.isNotEmpty &&
        subject.isNotEmpty &&
        isValidEmail(email) &&
        code.isNotEmpty;

    emit(state.copyWith(isFormValid: isFormValid));
  }

  // Método para actualizar el modo de validación
  void updateAutovalidateMode(AutovalidateMode mode) {
    emit(state.copyWith(autovalidateMode: mode));
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}
