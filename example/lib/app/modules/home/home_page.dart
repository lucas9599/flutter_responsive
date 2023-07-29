import 'package:example/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';

import 'package:flutter_responsive/utils/telas/tela_desktop.dart';

class HomePage extends TelaDesktopBase<HomeStore> {
  HomePage()
      : super(
            title: "Home",
            conteudo: () {
              return Container();
            });
}
