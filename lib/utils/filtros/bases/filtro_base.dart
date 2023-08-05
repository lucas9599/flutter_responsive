enum TipoJuncao {
  inList,
  notInList,
  iquals,
  notIquals,
  like,
  notLike,
  between,
}

///Classe que modela o funcionamento dos filtros
///
///__Coluna__: Coluna para filtrar no banco de dados
///
///__valor__: Parametros para o filtro. Pode ser uma lista, uma string ou map.
///
///__juncao__:Tipo de pesquisa realizada
///
///__labelChip__: Os chips são apresentados acima do datatable quando filtrados
///
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

  ///Retorna um json conforme o exemplo
  ///
  ///{"coluna": "id",
  ///
  ///"valor": [1,2,3],
  ///
  ///"juncao": 1
  ///
  ///}
  ///
  ///__Padrao para junção__
  ///
  ///* TipoJuncao.inList = 1
  ///* TipoJuncao.notInList = 2
  ///* TipoJuncao.iquals = 3
  ///* TipoJuncao.notIquals = 4
  ///* TipoJuncao.like = 5
  ///* TipoJuncao.notLike = 6
  ///* TipoJuncao.between = 7
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
