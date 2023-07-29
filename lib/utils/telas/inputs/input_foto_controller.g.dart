// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_foto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InputFotoController on _InputFotoControllerBase, Store {
  late final _$fotoAtom =
      Atom(name: '_InputFotoControllerBase.foto', context: context);

  @override
  String get foto {
    _$fotoAtom.reportRead();
    return super.foto;
  }

  @override
  set foto(String value) {
    _$fotoAtom.reportWrite(value, super.foto, () {
      super.foto = value;
    });
  }

  @override
  String toString() {
    return '''
foto: ${foto}
    ''';
  }
}
