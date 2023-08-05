## Features

TODO: Publicar API backend para o exemplo 

## Getting started

TODO: Package Inicial para flutter responsivo usando o flutter modular

## Additional information

TODO: No Momento não é possivel testar sem a api.

## Configurações Iniciais
O package utiliza o package **flutter_modular** para gerenciar os Modulos. Faça a configuração de acordo com a documentação do Flutter_Modular.
No main antes de iniciar  a classe "ModularApp", instancie a classe FlutterResponsive.
O package tambem utiliza o **bitsdojo_window**. Faça a configuração da pasta windows, linux, macos de acordo com a documentação, para um melhor resultado.
# Parametros
+ **descricaosistema**: Nome do Sistema. Localizado na tela de Login e no AppBar do painel principal.
+ **fundoLoginLateral**: Imagem que fica na lateral direita do Login.
+ **pathLogo**: Logo da Aplicação
+ **fundoLoginPrincipal**: Imagem de Fundo que fica atras do Painel de login.
+ **infoSistema**: Breve descrição do Sistema que esta localizado na lateral direita do login.
+ **menusExpandidos**: Lista de menus da classe "MenuExpandido". Menus que se adapta automaticamente a resolução da tela. 
Consulte a documentação na classe para parametraliza-la corretamente.


```dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/flutter_responsive.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu.dart';
import 'package:flutter_responsive_template/utils/telas/menus/menu_espandido.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_responsive_template/constantes.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  FlutterResposive(
    descricaosistema: "SIGA",
    fundoLoginLateral: "imagens/fundo_login.jpg",
    pathLogo: "imagens/avaliacao.png",
    fundoLoginPrincipal: "imagens/fundo2.jpg",
    infosistema: "Sistema de Avaliacao",
    menusexpandidos: [
      MenuExpandido(
        label: "Principal",
        indexMenu: 0,
        iconMobile: Icons.desktop_windows,
        menus: [
          Menu(
            label: "Home",
            icon: Icons.home,
            rota: "/home",
            mapeado: false,
          ),
        ],
      ),
    ],
  );
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
  if (isDesktop) {
    doWhenWindowReady(() {
      const initialSize = Size(900, 700);
      appWindow.minSize = Size(300, 500);
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}

```

<img src="/assets/img/login.PNG">
