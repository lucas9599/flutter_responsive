import 'package:flutter/material.dart';

///Classe para animar dados carregando
class CarregandoWidget extends StatelessWidget {
  const CarregandoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: 100,
          height: 100,
          child: const CircularProgressIndicator(
            semanticsLabel: "Carregando",
          ),
        ),
      ),
    );
  }
}
