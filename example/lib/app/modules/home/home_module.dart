import 'package:flutter_responsive_template/flutter_responsive.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(HomeStore.new, key: "tabela");
  }

  @override
  void routes(RouteManager r) {
    r.child("/", child: (contex) => HomePage());
  }
}
