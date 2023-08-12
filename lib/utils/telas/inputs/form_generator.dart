import 'package:enhance_stepper/enhance_stepper.dart';
import 'package:flutter_responsive_template/constantes.dart';
import 'package:flutter_responsive_template/utils/observables/carregando_widget.dart';
import 'package:flutter_responsive_template/utils/observables/conexao.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';
import 'package:flutter_responsive_template/utils/telas/partes_tela/posicioned_mensagens.dart';
import 'package:flutter_responsive_template/utils/telas/store/store_crud_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Tuples {
  String nome;
  IconData icon;
  Tuples({required this.nome, required this.icon});
}

///Classe de envio de formulario. É obrigatório informa o StoreCrudBase do formulario.
///
///__inputs__: Lista de widgets que inplementam a interface IInput
///
///__turples__: Será usado no cabeçalho do step para indicar a etapa selecionada, ou selecionar uma etapa.
///Se não desejar usar steps, passe por parametros uma lista vazia.
///
///__qtdInputsPorStep__: Separa os steps por quantidade de inputs. separe de acordo com a quantidade de turples criadas.
/// Se não Utilizou steps passe por parametros uma lista vazia.
///
/// __height__: Altura do modal
///
/// __width__: Largura do modal
///
/// __title__: Titulo do form
///
///
class FormGenerator<Store extends StoreCrudBase> extends StatefulWidget {
  final List<IInput> inputs;
  final List<Tuples> tuples;
  final List<int> qtdInputsPorStep;
  final double width;
  final double height;
  final String title;
  FormGenerator(
      {Key? key,
      required this.inputs,
      required this.title,
      required this.tuples,
      required this.qtdInputsPorStep,
      this.height = 400,
      this.width = 400})
      : super(key: key) {
    if (this.tuples.isEmpty) {
      this.tuples.add(
            Tuples(icon: Icons.edit, nome: ""),
          );
    }
    if (this.qtdInputsPorStep.isEmpty) {
      this.qtdInputsPorStep.add(this.inputs.length);
    }
  }

  @override
  State<FormGenerator> createState() => _FormGeneratorState<Store>();
}

class _FormGeneratorState<Store extends StoreCrudBase>
    extends State<FormGenerator> {
  final _formKey = GlobalKey<FormState>();

  final store = Modular.get<Store>();
  int continput = 0;
  Widget getSteps(
    int cont,
  ) {
    if (cont == 0) {
      continput = 0;
      for (int i = cont; i < widget.inputs.length; i++) {
        widget.inputs[i].setValue(this.store.dados);
      }
    }
    List<Widget> inputs = [];

    for (int j = continput;
        j < widget.qtdInputsPorStep[cont] + continput;
        j++) {
      inputs.add(widget.inputs[j]);
    }
    continput += widget.qtdInputsPorStep[cont];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: inputs,
    );
  }

  ///Valida os inputs do form
  validar() {
    if (!_formKey.currentState!.validate()) {
      Modular.get<Store>()
          .mensagemAviso(aviso: "Por favor, prencher todos dados obrigatórios");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    this.store.inputs = widget.inputs;
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: Builder(builder: (context) {
        return Stack(
          children: [
            Container(
              color: Colors.grey,
              height: !isTelaPequena(context) ? widget.height : null,
              width: !isTelaPequena(context) ? widget.width : null,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  actions: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(this.store.id! > 0 ? Icons.edit : Icons.add),
                        Text(
                          this.store.id! > 0 ? "Modo:Edição" : "Modo:Inclusão",
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                body: Observer(
                  builder: (context) => this.store.conexao ==
                          StatusConexao.carregando
                      ? const Column(children: [CarregandoWidget()])
                      : Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: const [
                                      0.7,
                                      0.1,
                                    ],
                                    colors: [
                                      Colors.grey.shade100,
                                      Colors.green,
                                    ],
                                  ),
                                ),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                  ),
                                  margin: const EdgeInsets.all(15),
                                  padding: const EdgeInsets.all(15),
                                  child: Form(
                                    autovalidateMode: AutovalidateMode.always,
                                    key: this._formKey,
                                    child: Observer(
                                      builder: (context) => widget
                                                  .qtdInputsPorStep.length >
                                              1
                                          ? EnhanceStepper(
                                              stepIconSize: 20,
                                              type: StepperType.horizontal,
                                              horizontalTitlePosition:
                                                  HorizontalTitlePosition
                                                      .bottom,
                                              horizontalLinePosition:
                                                  HorizontalLinePosition.top,
                                              currentStep: store.index,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              steps: List.generate(
                                                  widget.tuples.length,
                                                  (index) => EnhanceStep(
                                                        icon: Icon(
                                                          widget.tuples[index]
                                                              .icon,
                                                          color: Colors.blue,
                                                          size: 20,
                                                        ),
                                                        state: this
                                                                    .store
                                                                    .index ==
                                                                index
                                                            ? StepState.editing
                                                            : StepState
                                                                .disabled,
                                                        isActive:
                                                            this.store.index ==
                                                                index,
                                                        title: Text(widget
                                                            .tuples[index]
                                                            .nome),
                                                        content: this
                                                            .getSteps(index),
                                                      )).toList(),
                                              onStepCancel: () {
                                                _salvar();
                                                this.store.go(
                                                    -1, widget.tuples.length);
                                              },
                                              onStepContinue: () {
                                                if (validar()) {
                                                  _salvar();
                                                  this.store.go(
                                                      1, widget.tuples.length);
                                                }
                                              },
                                              onStepTapped: (index) {
                                                // ddlog(index);
                                                if (validar()) {
                                                  _salvar();
                                                  this.store.index = index;
                                                }
                                              },
                                              controlsBuilder: widget
                                                          .qtdInputsPorStep
                                                          .length >
                                                      1
                                                  ? (BuildContext context,
                                                      ControlsDetails
                                                          controlsDetails) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            Visibility(
                                                              visible: this
                                                                      .store
                                                                      .index !=
                                                                  widget.qtdInputsPorStep
                                                                          .length -
                                                                      1,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    controlsDetails
                                                                        .onStepContinue,
                                                                child: const Text(
                                                                    "Proximo"),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Visibility(
                                                              visible: this
                                                                      .store
                                                                      .index !=
                                                                  0,
                                                              child: TextButton(
                                                                onPressed:
                                                                    controlsDetails
                                                                        .onStepCancel,
                                                                child: const Text(
                                                                    "Voltar"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  : ((context, details) =>
                                                      Container()),
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: this.getSteps(0),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if (this.validar()) {
                                        Map<String, dynamic> dados = {};
                                        for (var element in widget.inputs) {
                                          dados.addAll(element.getValue());
                                        }
                                        this.store.salvar(dados);
                                      }
                                    },
                                    icon: const Icon(Icons.save),
                                    label: const Text("Salvar"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                ),
              ),
            ),
            PosicionedMensagem<Store>(
              left: isTelaPequena(context) ? null : widget.width - 250,
            )
          ],
        );
      }),
    );
  }

  _salvar() {
    Map<String, dynamic> dados = {};
    for (var element in widget.inputs) {
      dados.addAll(element.getValue());
    }
    this.store.dados.addAll(dados);
  }
}
