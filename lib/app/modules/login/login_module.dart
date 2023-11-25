import 'package:flutter_responsive_template/app/modules/login/login_page.dart';
import 'package:flutter_responsive_template/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(LoginStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (contex) => const LoginPage(),
    );
  }
}
