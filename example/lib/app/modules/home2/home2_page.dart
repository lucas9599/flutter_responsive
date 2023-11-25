import 'package:example/app/modules/home2/home2_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/telas/tela_base.dart';

class Home2Page extends TelaBase<Home2Store> {
  Home2Page({Key? key})
      : super(
          key: key,
          conteudo: () => Container(),
          title: "Home2",
        );
}
