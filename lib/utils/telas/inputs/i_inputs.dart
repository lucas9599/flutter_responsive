import 'package:flutter/cupertino.dart';

abstract class IInput extends Widget {
  const IInput({Key? key}) : super(key: key);

  Map<String, dynamic> getValue();
  void setValue(Map<String, dynamic> values);
  String get name;
  String get value;
}
