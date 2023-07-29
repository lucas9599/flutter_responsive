// ignore_for_file: sized_box_for_whitespace

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_responsive/constantes.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dio/dio.dart';

mixin Mensagens {
  erro({String motivo = "Erro, ao carregar dados"}) {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Text(motivo),
          ); // Center
        },
      ),
    );
    return doc.save();
  }

  visualizadorDePDF(Future<Uint8List> Function() gerar) async {
    await openMensagem(
      PdfPreview(
        build: (format) async {
          try {
            final res = await gerar();
            if (res.isNotEmpty) {
              return res;
            } else {
              return erro();
            }
          } on DioError catch (ex) {
            if ((ex.response?.statusCode ?? -1) == 401) {
              return erro(motivo: "Sessão expirada!Favor fazer novo login!");
            } else {
              return erro();
            }
          } catch (ex) {
            return erro();
          }
        },
      ),
      height: 1000,
      width: 1000,
    );
  }

  openMensagem(Widget mensagem, {double width = 500, double height = 500}) {
    Modular.to.push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
          insetPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.white,
          content: Container(
            width: !isTelaPequena(context) ? width : 1000,
            height: !isTelaPequena(context) ? height : 1000,
            child: Scaffold(
              appBar: AppBar(),
              body: mensagem,
            ),
          ),
        ),
      ),
    );
  }

  openDialogoConfirmacao(
      {required String mensagem,
      double width = 300,
      double height = 200}) async {
    return await Modular.to.push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) => AlertDialog(
          insetPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: Colors.white,
          content: Container(
            width: width,
            height: height,
            child: Scaffold(
              appBar: AppBar(
                title: Text(mensagem),
                leading: IconButton(
                  onPressed: () {
                    Modular.to.pop(false);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Modular.to.pop(true);
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text("Sim"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Modular.to.pop(false);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        icon: const Icon(Icons.cancel),
                        label: const Text("Não"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
