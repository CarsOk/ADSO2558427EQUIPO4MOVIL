part of 'form_validator_cubit.dart';

class FormValidatorState {
  final AutovalidateMode autovalidateMode;
  final bool isFormValid;

  FormValidatorState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.isFormValid = false,
  });

  FormValidatorState copyWith({
    AutovalidateMode? autovalidateMode,
    bool? isFormValid,
  }) {
    return FormValidatorState(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
