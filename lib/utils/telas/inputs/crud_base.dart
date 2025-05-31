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

///Tuples de um Step
class Tuples {
  final String nome;
  final IconData icon;
  final List<IInput> inputs;
  Tuples({
    required this.nome,
    required this.icon,
    required this.inputs,
  });
}

///Cria Um Form basico
///Esta implementado dois tipos de Forms. Com e sem steps (Etapas)
///__tuples__. Cria inputs com steps;
///__Inputs__ Lista de Inputs sem steps.
class CrudBase<CrudStore extends StoreCrudBase> extends StatefulWidget {
  final List<Tuples>? tuples;
  final List<IInput>? inputs;
  final double width;
  final double height;
  final String title;

  const CrudBase(
      {Key? key,
      required this.title,
      this.tuples,
      this.inputs,
      this.height = 400,
      this.width = 400})
      : assert(tuples != null && inputs == null ||
            inputs != null && tuples == null),
        super(key: key);
  /*: super(key: key) {
    /*
    if (this.tuples.isEmpty) {
      this.tuples.add(
            Tuples(icon: Icons.edit, nome: ""),
          );
    }
    if (this.qtdInputsPorStep.isEmpty) {
      this.qtdInputsPorStep.add(this.inputs.length);
    }
    */
  }
  */

  @override
  State<CrudBase> createState() => _CrudBaseState<CrudStore>();
}

class _CrudBaseState<CrudStore extends StoreCrudBase> extends State<CrudBase> {
  final _formKey = GlobalKey<FormState>();

  CrudStore store = Modular.get();
  Widget _getInputs() {
    if (widget.inputs != null) {
      for (int i = 0; i < widget.inputs!.length; i++) {
        widget.inputs![i].setValue(this.store.dados);
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.inputs!),
    );
  }

  EnhanceStep _getSteps(
    int index,
  ) {
    for (int i = 0; i < widget.tuples![index].inputs.length; i++) {
      widget.tuples![index].inputs[i].setValue(this.store.dados);
      this.store.inputs!.addAll(widget.tuples![index].inputs);
    }

    return EnhanceStep(
        icon: Icon(
          widget.tuples![index].icon,
          color: Colors.blue,
          size: 20,
        ),
        state:
            this.store.index == index ? StepState.editing : StepState.disabled,
        isActive: this.store.index == index,
        title: Text(widget.tuples![index].nome),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.tuples![index].inputs,
        ));
  }

  ///Valida um form
  bool validar() {
    if (!_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      store.mensagemAviso(
          aviso: "Por favor, prencher todos dados obrigatórios");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    this.store.inputs = widget.inputs ?? [];

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
                                      Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor ??
                                          Theme.of(context).colorScheme.primary,
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
                                        builder: (context) => widget.tuples !=
                                                null
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
                                                        widget.tuples!.length,
                                                        (index) => this
                                                            ._getSteps(index))
                                                    .toList(),
                                                onStepCancel: () {
                                                  _salvar();
                                                  this.store.go(-1,
                                                      widget.tuples!.length);
                                                },
                                                onStepContinue: () {
                                                  if (validar()) {
                                                    _salvar();
                                                    this.store.go(1,
                                                        widget.tuples!.length);
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
                                                            .tuples !=
                                                        null
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
                                                                    widget.tuples!
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
                                                                child:
                                                                    TextButton(
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
                                            : _getInputs()),
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
                                        for (var element
                                            in this.store.inputs!) {
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
            PosicionedMensagem<CrudStore>(
              left: isTelaPequena(context) ? null : widget.width - 250,
            )
          ],
        );
      }),
    );
  }

  void _salvar() {
    Map<String, dynamic> dados = {};
    for (var element in this.store.inputs!) {
      dados.addAll(element.getValue());
    }
    this.store.dados.addAll(dados);
  }
}
