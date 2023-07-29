// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_chekbox_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ControllerCheckBox on _ControllerCheckBoxBase, Store {
  late final _$selecionadoAtom =
      Atom(name: '_ControllerCheckBoxBase.selecionado', context: context);

  @override
  bool get selecionado {
    _$selecionadoAtom.reportRead();
    return super.selecionado;
  }

  @override
  set selecionado(bool value) {
    _$selecionadoAtom.reportWrite(value, super.selecionado, () {
      super.selecionado = value;
    });
  }

  late final _$visibleAtom =
      Atom(name: '_ControllerCheckBoxBase.visible', context: context);

  @override
  bool get visible {
    _$visibleAtom.reportRead();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.reportWrite(value, super.visible, () {
      super.visible = value;
    });
  }

  @override
  String toString() {
    return '''
selecionado: ${selecionado},
visible: ${visible}
    ''';
  }
}
