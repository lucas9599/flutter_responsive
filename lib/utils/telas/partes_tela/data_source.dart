import 'package:flutter_responsive_template/utils/telas/datatable/data.dart';
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  // Generate some made-up data
  final Dados? datatype;

  DataSource(this.datatype);

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => (datatype?.dados?.length ?? 0);
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return datatype!.processarRow(d: datatype!.dados![index]);
  }

  List<DataRow> getRows() {
    return List.generate(datatype!.dados!.length,
        (index) => datatype!.processarRow(d: datatype!.dados![index]));
  }
}
