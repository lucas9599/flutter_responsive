import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_responsive_template/app/modules/login/login_store.dart';
import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/observables/carregando_widget.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/telas/menus/windows_buttons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.build_circle_rounded),
          onPressed: () {
            store.openConfiguracao();
          }),
      body: Observer(
        builder: (context) => store.conexao == StatusConexao.carregando
            ? const Column(
                children: [CarregandoWidget()],
              )
            : Column(
                children: [
                  isDesktop
                      ? SizedBox(
                          height: 40,
                          child: WindowTitleBarBox(
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Expanded(child: MoveWindow()),
                                  const WindowButtons()
                                ],
                              ),
                            ),
                          ))
                      : Container(),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: _adjustColorShade(color, -200),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            opacity: 0.3,
                            image: AssetImage(
                              fundoPrincipal,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 700,
                            height:
                                isTelaGrande(context) ? 600 : double.infinity,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: SingleChildScrollView(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Image.asset(
                                              logo,
                                            ),
                                          ),
                                          const Text(
                                            "FAÇA O LOGIN",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white60),
                                          ),
                                          store.email,
                                          store.senha,
                                          store.salvar,
                                          SizedBox(
                                            height: 50,
                                            child: Observer(
                                              builder: (context) => Text(
                                                store.mensagem,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  _adjustColorShade(
                                                                      color,
                                                                      -200))),
                                                      onPressed: () {
                                                        store.login();
                                                      },
                                                      child:
                                                          const Text("Entrar")))
                                            ],
                                          )
                                        ]),
                                  ),
                                )),
                                Visibility(
                                  visible: isTelaGrande(context),
                                  child: Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          opacity: 0.3,
                                          image: AssetImage(
                                            fundo,
                                          ),
                                        ),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.school,
                                              color: Colors.white, size: 50),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                nomesistema,
                                                style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                              thickness: 1,
                                              color: Colors.white),
                                          Text(
                                            nomeSistemaDescricao,
                                            style: TextStyle(
                                                fontSize: 17,
                                                shadows: const [
                                                  Shadow(color: Colors.black)
                                                ],
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "SEJA BEM VINDO!",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                                    .withOpacity(0.9)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )

                        /* Expanded(
          child: WindowBorder(
            color: color,
            width: 1,
            child: FlutterLogin(
              title: 'Avaliação',
              logo: AssetImage('imagens/avaliacao.png'),
              onLogin: _authUser,
              onSignup: _signupUser,
              onSubmitAnimationCompleted: () {
                Modular.to.navigate("/home/");
              },
              messages: LoginMessages(passwordHint: "Senha"),
              hideForgotPasswordButton: true,
              onRecoverPassword: _recoverPassword,
            ),
          ),
        ),*/
                        ),
                  )
                ],
              ),
      ),
    );
  }

  Color _adjustColorShade(Color color, int amount) {
    assert(amount >= -255 && amount <= 255);

    int red = color.red + amount;
    int green = color.green + amount;
    int blue = color.blue + amount;

    return Color.fromARGB(color.alpha, red.clamp(0, 255), green.clamp(0, 255),
        blue.clamp(0, 255));
  }
}
