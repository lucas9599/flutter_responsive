import 'package:flutter_responsive_template/utils/repository/chaves.dart';
import 'package:flutter_responsive_template/utils/repository/repository_base.dart';

class PerfisRepository extends Repository {
  PerfisRepository()
      : super("servidor_perfil",
            tipoApi: TipoApi.normal, carregarInclusao: true);
}
