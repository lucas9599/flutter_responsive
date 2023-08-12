/// Classe de validadação de uma data
abstract class Validador {
  static bool validaData(String data) {
    // data é menor que 8
    if (data.length < 10) {
      return false;
    } else {
      // verifica se a data possui
      // a barra (/) de separação
      if (data.contains("/")) {
        //
        List partes = data.split("/");
        // pega o dia da data
        int dia = int.parse(partes[0]);
        // pega o mês da data
        int mes = int.parse(partes[1]);
        // prevenindo Notice: Undefined offset: 2
        // caso informe data com uma única barra (/)
        int ano = int.parse(partes[2]);

        if (ano < 1900) {
          return false;
        } else {
          // verifica se a data é válida

          if (dia <= 0 || mes > 12 || mes < 1) {
            return false;
          }
          if ([1, 3, 5, 6, 8, 10, 12].contains(mes)) {
            if (dia > 31) {
              return false;
            }
          } else if (mes == 2) {
            if ((((ano % 4 == 0) && (ano % 100 != 0)) || (ano % 400 == 0))) {
              if (dia > 29) return false;
            } else if (dia > 28) {
              return false;
            }
          } else {
            if (dia > 30) return false;
          }
          return true;
        }
      } else {
        return false;
      }
    }
  }
}
