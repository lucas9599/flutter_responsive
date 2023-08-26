import 'package:example/app/modules/home2/home2_Page.dart';
import 'package:example/app/modules/home2/home2_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Home2Module extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => Home2Store()),];

  @override
  final List<ModularRoute> routes = [ChildRoute('/', child: (_, args) => Home2Page()),];

}