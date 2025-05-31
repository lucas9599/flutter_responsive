import 'package:example/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/telas/tela_base.dart';

class HomePage extends TelaBase<HomeStore> {
  HomePage({Key? key})
      : super(
          key: key,
          title: "Home",
          conteudo: () {
            return Container();
          },
        );
}
