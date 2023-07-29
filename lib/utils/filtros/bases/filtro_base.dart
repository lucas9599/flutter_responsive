enum TipoJuncao {
  inList,
  notInList,
  iquals,
  notIquals,
  like,
  notLike,
  between,
}

class FiltroBase {
  final String coluna;
  final dynamic valor;
  final TipoJuncao juncao;
  final String labelChip;

  FiltroBase({
    this.coluna = "id",
    required this.valor,
    this.juncao = TipoJuncao.inList,
    this.labelChip = "",
  });

  Map<String, dynamic> toJson() {
    int res = 0;
    switch (juncao) {
      case TipoJuncao.inList:
        res = 1;
        break;
      case TipoJuncao.notInList:
        res = 2;
        break;
      case TipoJuncao.iquals:
        res = 3;
        break;
      case TipoJuncao.notIquals:
        res = 4;
        break;
      case TipoJuncao.like:
        res = 5;
        break;
      case TipoJuncao.notLike:
        res = 6;
        break;
      case TipoJuncao.between:
        res = 7;
        break;
    }
    return {
      "coluna": coluna,
      "valor": valor,
      "juncao": res,
    };
  }
}
