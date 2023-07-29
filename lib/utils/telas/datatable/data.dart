import 'package:flutter_responsive/utils/cards/card_duas_colunas.dart';
import 'package:flutter_responsive/utils/cards/card_label_valor.dart';
import 'package:flutter_responsive/utils/module_base/app_controller.dart';
import 'package:flutter_responsive/utils/telas/datatable/datamobile.dart';
import 'package:flutter_responsive/utils/telas/menus/menu_button_permissao.dart';
import 'package:flutter_responsive/utils/telas/store/store_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:data_table_2/data_table_2.dart';

abstract class Dados implements DadosMobile {
  _comparar(a, b, crescente) {
    if ((a is num && b is num)) {
      return crescente ? a.compareTo(b) : b.compareTo(a);
    } else {
      return crescente
          ? a.toString().compareTo(b.toString())
          : b.toString().compareTo(a);
    }
  }

  ordernar({String campo = "descricao", String? sublist, required int index}) {
    Modular.get<IAppController>().sorting(
        ordernador: () => dados!.sort((a, b) => _comparar(
            (sublist != null ? a[campo][sublist] : a[campo]),
            (sublist != null ? b[campo][sublist] : b[campo]),
            Modular.get<IAppController>().crescente)),
        index: index);
  }

  List<DataColumn> get colunas => [
        const DataColumn2(
          fixedWidth: 70,
          label: Text("Ação"),
        ),
        DataColumn2(
          fixedWidth: 100,
          label: const Text("Cod"),
          numeric: true,
          onSort: (columnIndex, ascending) {
            ordernar(campo: "id", index: columnIndex);
          },
        ),
        DataColumn2(
          onSort: (columnIndex, ascending) {
            ordernar(index: columnIndex);
          },
          label: const Text("Descricao"),
        ),
      ];
  bool selected = false;
  List? dados;

  Widget getmenus({required Map<String, dynamic> d}) => MenuButtonPermissao(
        itens: [
          MenuButtonPermissaoItem(
            iconData: Icons.edit,
            name: "editar",
            descricao: "Editar",
            onSelected: () {
              Modular.get<StoreBase>().editar(id: d['id']);
            },
            // icon: Icon(Icons.edit),
          ),
          MenuButtonPermissaoItem(
            name: "excluir",
            iconData: Icons.delete,
            descricao: "Excluir",
            onSelected: () {
              Modular.get<StoreBase>().delete(id: d['id']);
            },
            // icon: Icon(Icons.delete),
          ),
        ],
      );

  DataRow processarRow({required Map<String, dynamic> d}) {
    return DataRow2(cells: [
      DataCell(getmenus(d: d)),
      DataCell(Text(d['id'].toString())),
      DataCell(
        Text(d['descricao']),
      ),
    ]);
  }

  // List<DataRow> get rows {
  // if (this.dados == null) {
  // return [];
  //} else {
  //return List.generate(
  //  dados!.length,
  //(index) =>
  //  this.processarRow(d: dados![index] as Map<String, dynamic>));
  // }
  // }

  @override
  Widget get card => ListView.builder(
        itemCount: dados!.length,
        itemBuilder: (context, index) => CardDuasColunas(
          id: dados![index]['id'],
          codigo: LabelValor(
            label: "Código",
            valor: dados![index]['id'].toString(),
          ),
          descricao: LabelValor(
            label: "Descrição",
            valor: dados![index]['descricao'].toString(),
          ),
        ),
      );
}
