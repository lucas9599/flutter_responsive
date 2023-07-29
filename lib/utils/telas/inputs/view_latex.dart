// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'view_latex.g.dart';

class ViewLatex = _ViewLatexBase with _$ViewLatex;

abstract class _ViewLatexBase with Store {
  @observable
  bool latex = false;
}
