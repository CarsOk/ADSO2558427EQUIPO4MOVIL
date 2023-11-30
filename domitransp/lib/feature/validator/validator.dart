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

  static String? consecutivo(String? consecutivo){
    if (consecutivo!.isNotEmpty) {
      final codigoConcecutivo = int.tryParse(consecutivo);
      if (codigoConcecutivo != null) {
        if (codigoConcecutivo < 1 || codigoConcecutivo.toString().length > 5) {
        return 'Ingresar concecutivo valido';
      } else {
        return null;
      }
      } else {
        return 'Ingrese tipo de dato valido';
      }
      
    } else {
      return 'Campo requerido';
    }
  }

  // static String? tipoEmpaque(String? tipoEmpaque){
  //   if (tipoEmpaque!.isNotEmpty) {
  //     final codigoConcecutivo = int.tryParse(tipoEmpaque);
  //     if (codigoConcecutivo != null) {
  //       if (codigoConcecutivo < 1 || codigoConcecutivo.toString().length > 5) {
  //       return 'Ingresar concecutivo valido';
  //     } else {
  //       return null;
  //     }
  //     } else {
  //       return 'Ingrese cantidad valida';
  //     }
      
  //   } else {
  //     return 'Campo requerido';
  //   }
  // }

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

  static String? tipoPaquete(String? cantidad) {
    if(cantidad!.isNotEmpty){
      if (int.tryParse(cantidad!) != null ) {
        print('la cantidad es ${cantidad}');
         if (int.tryParse(cantidad!) !>= 1 ) {
          if (int.tryParse(cantidad!) !> 999) {
            return 'Cantidad maxima (999)';
          } else {
            return null;
          }
         } else {
          return 'Cantidad minima 1';
         }
        
      } else {
        return 'Cantidad invalida';
      }
    }
  }

  static String? inputDate(dynamic fecha) {
    if (fecha == null) {
      return 'Selecciona una fecha';
    }
    print('El valor de vlue del input fecha es $fecha y es tipo ${fecha.runtimeType}');
    final now = DateTime.now();
    final minDate = now.add(const Duration(days: 5));
    final maxDate =
        now.add(const Duration(days: 730));

    if (fecha.isBefore(minDate)) {
      return 'La fecha minima es de 5 días despues de la actual';
    }

    if (fecha.isAfter(maxDate)) {
      return 'Supero fecha permitida (maximo 2 años)';
    }

    return null;
  }
}
