import 'dart:convert';
import 'package:flutter_responsive/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive/utils/telas/inputs/input_foto_controller.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:file_selector/file_selector.dart';

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
}

class _InputFotoState extends State<InputFoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.green.shade100),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.label,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green.shade900),
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
                  const XTypeGroup typeGroup = XTypeGroup(
                    label: 'images',
                    extensions: <String>['jpg', 'png'],
                  );
                  final XFile? file = await openFile(
                      acceptedTypeGroups: <XTypeGroup>[typeGroup]);
                  // #enddocregion SingleOpen
                  if (file == null) {
                    // Operation was canceled by the user.
                    return;
                  } else {
                    widget.controller.foto =
                        base64.encode(await file.readAsBytes());
                  }

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
