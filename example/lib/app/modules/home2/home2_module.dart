import 'package:example/app/modules/home2/home2_Page.dart';
import 'package:example/app/modules/home2/home2_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Home2Module extends Module {
  @override
  void binds(i) {
    i.addSingleton(Home2Store.new, key: "tabela");
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (contex) => Home2Page());
  }
}
