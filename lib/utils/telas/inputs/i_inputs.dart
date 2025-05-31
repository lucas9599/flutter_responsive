import 'package:flutter/material.dart';

///Interface para utilizar o crudBase
///Qualquer input deve implemetar os metodos para ser incluido em um form
abstract class IInput extends Widget {
  const IInput({Key? key}) : super(key: key);

  ///Retorna o map com a chave sendo o get Name
  Map<String, dynamic> getValue();
  void clean();

  ///Recebe um map e preencher o input.
  ///Pesquise o valor de acordo com a key do metood get name
  void setValue(Map<String, dynamic> values);

  ///Key do map para pegar a informação da api
  String get name;
  String get value;
}
