## Features

TODO: Publicar API backend para o exemplo 

## Getting started

TODO: Package Inicial para flutter responsivo usando o flutter modular

## Additional information

TODO: No Momento não é possivel testar sem a api.

## Configurações Iniciais
Utilizamos o package **flutter_modular** para gerenciar os Modulos. Faça a configuração de acordo com a documentação do Flutter_Modular.
No main antes de iniciar  a classe "ModularApp", instancie a classe FlutterResponsive.
O package tambem utiliza o **bitsdojo_window**. Faça a configuração da pasta windows, linux, macos de acordo com a documentação para um melhor resultado nas versões para desktop.
# Parametros
+ **descricaosistema**: Nome do sistema. Localizado na tela de Login e no AppBar do Painel Principal.
+ **fundoLoginLateral**: Imagem que fica na lateral direita do Login.
+ **pathLogo**: Logo da Aplicação
+ **fundoLoginPrincipal**: Imagem de fundo que fica atras do Painel de login.
+ **infoSistema**: Breve descrição do sistema que esta localizado na lateral direita do login.
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
# AppController
Crie uma classe que herda da Classe IAppController para ser usada como Bind do AppModule. 

```dart
import 'package:flutter_responsive_template/utils/module_base/app_controller.dart';

class AppController extends IAppController {}
```

# AppModule
Para um correto funcionamento do package é necessario que os seguintes modulos sejam instanciados no AppModule com o mesmo nome de rota.
Apenas o HomeModule é necessario Criar. Os outros modulos importe do package.
+ **Modular.initialRoute:**: LoginModule(). 
+ **/home**: HomeModule(). 
+ **/usuario**: UsuariosModule(). 
+ **/perfis**: PerfisModule()
+ **/filtrarusuario**: FiltroUsuario()
+ **/filtrardescricao**:FiltroDescricao()

```dart
import 'package:example/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive_template/app/modules/login/login_module.dart';
import 'package:flutter_responsive_template/app/modules/usuarios/usuarios_module.dart';
import 'package:flutter_responsive_template/app/modules/perfis/perfis_module.dart';
import 'package:flutter_responsive_template/utils/rotas/rota_modal.dart';
import 'package:flutter_responsive_template/utils/filtros/herdados/filtro_usuarios.dart';
import 'package:flutter_responsive_template/utils/filtros/herdados/filtro_descricao.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => AppController())];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: LoginModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/home",
      module: HomeModule(),
      transition: TransitionType.noTransition,
    ),
    ModuleRoute(
      "/usuario",
      module: UsuariosModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      "/perfis",
      module: PerfisModule(),
      transition: TransitionType.fadeIn,
    ),
    RotaModal(
      '/filtrarusuario',
      child: (_, args) => FiltroUsuario(),
    ),
    RotaModal('/filtrardescricao', child: (_, args) => FiltroDescricao())
  ];
}
```
# Padrao para Herança das Pages e Stores
+ As classes "Pages" devem herdar da classe TelaDesktopBase. É obrigatório indicar o seu Store (Herdado do StoreBase). Conforme o exemplo da HomePage abaixo.

```dart
import 'package:example/app/modules/home/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/utils/telas/tela_desktop.dart';

class HomePage extends TelaDesktopBase<HomeStore> {
  HomePage()
      : super(
            title: "Home",
            conteudo: () {
              return Container();
            });
}
```
+ As classes "Stores" devem  Herdar do HomeStore.

```dart
import 'package:flutter_responsive_template/utils/telas/store/store_base.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase extends StoreBase with Store {}
```

<img src="/assets/img/login.PNG">
