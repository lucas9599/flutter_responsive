import 'package:flutter_responsive/utils/repository/chaves.dart';
import 'package:flutter_responsive/utils/repository/repository_base.dart';

class UsuariosRepository extends Repository {
  UsuariosRepository()
      : super("usuario", tipoApi: TipoApi.geral, tabela: "servidor_usuario");
}
