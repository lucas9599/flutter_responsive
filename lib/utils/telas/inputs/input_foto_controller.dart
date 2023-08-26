// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import 'package:image/image.dart' as img;
import 'package:file_selector/file_selector.dart';
part 'input_foto_controller.g.dart';

///controlador do InputFoto
class InputFotoController = _InputFotoControllerBase with _$InputFotoController;

abstract class _InputFotoControllerBase with Store {
  @observable
  String foto = "";
  _decodeImage(Uint8List image) {
    final a = img.decodeImage(image)!;
    final resize = img.copyResize(
      a,
      width: 200,
    );

    Uint8List i = img.encodePng(resize);
    foto = base64.encode(i);
  }

  ///abre imagens e redimenciona para 100 de largura
  openImagens() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>['jpg', 'png'],
    );
    final XFile? file =
        await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
    // #enddocregion SingleOpen
    if (file == null) {
      // Operation was canceled by the user.
      return;
    } else {
      _decodeImage(await file.readAsBytes());
    }
  }
}
