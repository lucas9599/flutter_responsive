import 'package:mobx/mobx.dart';
import 'package:flutter_responsive_template/utils/telas/inputs/i_inputs.dart';

part 'input_dados_controller.g.dart';

// ignore: library_private_types_in_public_api
class InputDadosController = _InputDadosControllerBase
    with _$InputDadosController;

abstract class _InputDadosControllerBase with Store {
  final ObservableList<Map<String, dynamic>> dados =
      <Map<String, dynamic>>[].asObservable();

  bool inicializado = false;
  String Function(Map<String, dynamic> dados)? identificador;

  IInput? input;
  int? indexEdicao;
  Map<String, dynamic>? dadosEmEdicao;

  // ============ MÉTODOS EXISTENTES ============

  void inicializar(Map<String, dynamic> values, String name) {
    if (values[name] != null) {
      List<Map<String, dynamic>> a =
          List<Map<String, dynamic>>.from(values[name]);
      if (!inicializado) {
        dados.addAll(a);
        inicializado = true;
      }
    }
  }

  void adicionar() {
    Map<String, dynamic> v = input!.getValue();

    if (v.isNotEmpty) {
      // Verifica duplicatas
      if (identificador != null && dados.isNotEmpty) {
        bool existeDuplicata =
            dados.any((item) => identificador!(item) == identificador!(v));

        if (existeDuplicata) {
          return;
        }
      }

      if (indexEdicao != null) {
        // Atualiza item existente
        dadosEmEdicao!.addAll(v);
        dados.insert(indexEdicao!, dadosEmEdicao!);
        input!.clean();
        indexEdicao = null;
        dadosEmEdicao = null;
      } else {
        // Adiciona novo
        dados.add(v);
        input!.clean();
      }
    }
  }

  void editar(int index) {
    dadosEmEdicao = dados[index];
    indexEdicao = index;
    input?.setValue(dadosEmEdicao!);
    dados.removeAt(index);
  }

  // ============ NOVOS MÉTODOS ============

  // Remove um item pelo índice
  void remover(int index) {
    if (index >= 0 && index < dados.length) {
      dados.removeAt(index);
    }
  }

  // Remove um item pelo identificador
  void removerPorId(Map<String, dynamic> item) {
    if (identificador != null) {
      dados.removeWhere((dado) => identificador!(dado) == identificador!(item));
    }
  }

  // Limpa toda a lista
  void limparTodos() {
    dados.clear();
    input?.clean();
    indexEdicao = null;
    dadosEmEdicao = null;
  }

  // Insere em posição específica
  void inserirNaPosicao(Map<String, dynamic> item, int posicao) {
    if (posicao < 0) posicao = 0;
    if (posicao > dados.length) posicao = dados.length;

    if (identificador != null) {
      bool existeDuplicata =
          dados.any((dado) => identificador!(dado) == identificador!(item));
      if (existeDuplicata) {
        return;
      }
    }

    dados.insert(posicao, item);
  }

  // Atualiza item em posição específica
  void atualizarNaPosicao(Map<String, dynamic> item, int posicao) {
    if (posicao >= 0 && posicao < dados.length) {
      dados[posicao] = item;
    }
  }

  // Move item de uma posição para outra
  void moverItem(int deIndex, int paraIndex) {
    if (deIndex < 0 ||
        deIndex >= dados.length ||
        paraIndex < 0 ||
        paraIndex >= dados.length) {
      return;
    }

    if (deIndex == paraIndex) return;

    var item = dados.removeAt(deIndex);

    if (paraIndex > deIndex) {
      dados.insert(paraIndex - 1, item);
    } else {
      dados.insert(paraIndex, item);
    }
  }

  // Ordena por um campo
  void ordenarPor(String campo, {bool crescente = true}) {
    dados.sort((a, b) {
      var valorA = a[campo];
      var valorB = b[campo];

      if (valorA == null && valorB == null) return 0;
      if (valorA == null) return crescente ? -1 : 1;
      if (valorB == null) return crescente ? 1 : -1;

      if (valorA is String && valorB is String) {
        return crescente ? valorA.compareTo(valorB) : valorB.compareTo(valorA);
      }

      if (valorA is num && valorB is num) {
        return crescente ? valorA.compareTo(valorB) : valorB.compareTo(valorA);
      }

      return 0;
    });
  }

  // Getter para verificar se está vazio
  bool get isEmpty => dados.isEmpty;

  // Getter para verificar se não está vazio
  bool get isNotEmpty => dados.isNotEmpty;

  // Getter para quantidade de itens
  int get length => dados.length;

  // Busca item pelo identificador
  Map<String, dynamic>? buscarPorId(dynamic id) {
    if (identificador == null) return null;

    try {
      return dados.firstWhere((item) => identificador!(item) == id.toString());
    } catch (e) {
      return null;
    }
  }

  // Verifica se existe item com o identificador
  bool existePorId(dynamic id) {
    if (identificador == null) return false;

    return dados.any((item) => identificador!(item) == id.toString());
  }
}
