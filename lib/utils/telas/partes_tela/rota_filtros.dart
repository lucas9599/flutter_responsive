class RotaFiltros {
  final String label;
  final String rota;
  final bool isInAppModule;

  ///String rota, rota no appModule da tela do filtro que herda da classe FiltroTelaBase. Exemplo filtarconteudos
  RotaFiltros(
      {required this.label, required this.rota, this.isInAppModule = true});
}
