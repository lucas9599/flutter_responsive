// ignore_for_file: file_names
import 'package:flutter_responsive/utils/telas/inputs/i_inputs.dart';
import 'package:flutter/material.dart';

class InputCard extends StatefulWidget implements IInput {
  final String label;
  final int quantidade;
  final IconData iconData;
  const InputCard(
      {Key? key,
      required this.label,
      required this.quantidade,
      required this.iconData})
      : super(key: key);

  @override
  State<InputCard> createState() => _InputCardState();

  @override
  Map<String, dynamic> getValue() {
    return {};
  }

  @override
  String get name => "";

  @override
  void setValue(Map<String, dynamic> values) {}

  @override
  String get value => "";
}

class _InputCardState extends State<InputCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Center(
          child: ListTile(
            leading: Icon(widget.iconData),
            title: Text(
              widget.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: CircleAvatar(child: Text(widget.quantidade.toString())),
          ),
        ),
      ),
    );
  }
}
