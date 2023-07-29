// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IAppController on _IAppControllerBase, Store {
  late final _$esconderAtom =
      Atom(name: '_IAppControllerBase.esconder', context: context);

  @override
  bool get esconder {
    _$esconderAtom.reportRead();
    return super.esconder;
  }

  @override
  set esconder(bool value) {
    _$esconderAtom.reportWrite(value, super.esconder, () {
      super.esconder = value;
    });
  }

  late final _$crescenteAtom =
      Atom(name: '_IAppControllerBase.crescente', context: context);

  @override
  bool get crescente {
    _$crescenteAtom.reportRead();
    return super.crescente;
  }

  @override
  set crescente(bool value) {
    _$crescenteAtom.reportWrite(value, super.crescente, () {
      super.crescente = value;
    });
  }

  late final _$indexsortAtom =
      Atom(name: '_IAppControllerBase.indexsort', context: context);

  @override
  int get indexsort {
    _$indexsortAtom.reportRead();
    return super.indexsort;
  }

  @override
  set indexsort(int value) {
    _$indexsortAtom.reportWrite(value, super.indexsort, () {
      super.indexsort = value;
    });
  }

  late final _$indexAtom =
      Atom(name: '_IAppControllerBase.index', context: context);

  @override
  int get index {
    _$indexAtom.reportRead();
    return super.index;
  }

  @override
  set index(int value) {
    _$indexAtom.reportWrite(value, super.index, () {
      super.index = value;
    });
  }

  late final _$ordenacaoAtom =
      Atom(name: '_IAppControllerBase.ordenacao', context: context);

  @override
  Sorting get ordenacao {
    _$ordenacaoAtom.reportRead();
    return super.ordenacao;
  }

  @override
  set ordenacao(Sorting value) {
    _$ordenacaoAtom.reportWrite(value, super.ordenacao, () {
      super.ordenacao = value;
    });
  }

  late final _$_IAppControllerBaseActionController =
      ActionController(name: '_IAppControllerBase', context: context);

  @override
  dynamic sorting({required Function ordernador, required int index}) {
    final _$actionInfo = _$_IAppControllerBaseActionController.startAction(
        name: '_IAppControllerBase.sorting');
    try {
      return super.sorting(ordernador: ordernador, index: index);
    } finally {
      _$_IAppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic escondermenu() {
    final _$actionInfo = _$_IAppControllerBaseActionController.startAction(
        name: '_IAppControllerBase.escondermenu');
    try {
      return super.escondermenu();
    } finally {
      _$_IAppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
esconder: ${esconder},
crescente: ${crescente},
indexsort: ${indexsort},
index: ${index},
ordenacao: ${ordenacao}
    ''';
  }
}
