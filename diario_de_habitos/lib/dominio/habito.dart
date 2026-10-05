class Habito {
  final String nome;
  final String meta;
  final String icone; // chave neutra converte em IconData.
  final int diasSeguidos;
  final int realizadoHoje;
  final int metaHoje;
  final int percentualMes;
  final String descricao;

  Habito(
    this.nome,
    this.meta,
    this.icone,
    this.diasSeguidos,
    this.realizadoHoje,
    this.metaHoje,
    this.percentualMes,
    this.descricao,
  );
}
