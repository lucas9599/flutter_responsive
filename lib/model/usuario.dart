// ignore_for_file: unnecessary_this

import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/utils/telas/datatable/data.dart';

class Usuario extends Dados {
  String? usuario;
  String? senha;

  String? email;
  bool? admin;
  int? id;
  Uint8List? foto;
  String? token;
  Map<String, dynamic>? permissoes;

  Usuario(
      {this.usuario,
      this.senha,
      this.email,
      this.admin,
      this.id,
      this.foto,
      this.permissoes,
      this.token});

  Map<String, dynamic> toJson() {
    return {
      "usuario": this.usuario ?? "",
      "senha": this.senha ?? "",
      "email": this.email ?? "",
      "admin": this.admin ?? false,
    };
  }

  @override
  List<DataColumn> get colunas => [
        const DataColumn2(fixedWidth: 100, label: Text("Ação")),
        DataColumn2(
          fixedWidth: 100,
          label: const Text("Cod"),
          onSort: (columnIndex, ascending) =>
              this.ordernar(index: columnIndex, campo: "id"),
          numeric: true,
        ),
        DataColumn2(
          label: const Text("Descricao"),
          onSort: (columnIndex, ascending) =>
              this.ordernar(index: columnIndex, campo: "descricao"),
        ),
        DataColumn2(
          label: const Text("Email"),
          onSort: (columnIndex, ascending) =>
              this.ordernar(index: columnIndex, campo: "email"),
        ),
      ];

  @override
  DataRow processarRow({required Map<String, dynamic> d}) {
    return DataRow(cells: [
      DataCell(this.getmenus(d: d)),
      DataCell(Text(d['id'].toString())),
      DataCell(
        Text(d['descricao']),
      ),
      DataCell(
        Text(d['email']),
      ),
    ]);
  }
}
