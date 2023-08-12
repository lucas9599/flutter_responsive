import 'package:flutter/cupertino.dart';

///Interface principal dos Inputs. Se desejar criar novos inputs é necessario implementar esta classe.
abstract class IInput extends Widget {
  const IInput({Key? key}) : super(key: key);

  ///retorna um mapa com os valores do input
  ///
  ///__IMPORTANTE__: a key dever ser o mesmo "get name"
  ///
  Map<String, dynamic> getValue();

  ///Recebe um map para popular o seu input.
  ///
  ///__INPORTANTE__: A key do map é o "neme";
  void setValue(Map<String, dynamic> values);

  ///Retorna o name ("Use para identificar a key no map")
  String get name;

  String get value;
}
