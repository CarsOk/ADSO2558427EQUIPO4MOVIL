class Validator {
  static String? email(String? email) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    final validarEmail = emailRegex.hasMatch(email ?? '');
    if (!validarEmail) {
      return 'Ingresar email válido';
    }
    return null;
  }

  static String? pinput(dynamic digitos) {
    if (int.tryParse(digitos) != null) {
      if (digitos.toString().length != 4) {
        return 'Ingresar codigo valido';
      } else {
        return null;
      }
    } else {
      return 'Ingresar codigo valido';
    }
  }
}
