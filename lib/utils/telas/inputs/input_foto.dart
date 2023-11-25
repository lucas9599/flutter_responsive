import 'dart:convert';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/input_foto_controller.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

///Abre uma foto em gereciador de arquivo
class InputFoto extends StatefulWidget implements IInput {
  final InputFotoController controller = InputFotoController();
  @override
  final String name;
  final String label;
  InputFoto({Key? key, required this.name, required this.label})
      : super(key: key);

  @override
  State<InputFoto> createState() => _InputFotoState();

  @override
  Map<String, dynamic> getValue() {
    return {name: controller.foto};
  }

  @override
  void setValue(Map<String, dynamic> values) {
    controller.foto = values[name] ?? "";
  }

  @override
  String get value => controller.foto;

  @override
  clean() {
    controller.foto = "";
  }
}

class _InputFotoState extends State<InputFoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          Observer(
            builder: (context) => Container(
              // width: 250,
              //height: 150,
              padding: const EdgeInsets.all(5),
              child: widget.controller.foto.isNotEmpty
                  ? Image.memory(
                      base64.decode(widget.controller.foto),
                      fit: BoxFit.fill,
                    )
                  : const Icon(
                      Icons.image,
                      size: 40,
                    ),
            ),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton.icon(
                onPressed: () async {
                  widget.controller.openImagens();
                  // User canceled the picker
                },
                icon: const Icon(Icons.file_open),
                label: const Text("Abrir")),
          )
        ],
      ),
    );
  }
}
