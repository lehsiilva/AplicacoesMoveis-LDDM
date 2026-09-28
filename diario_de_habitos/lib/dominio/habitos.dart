import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../confirmar_exclusao.dart';
import '../dominio/habitos_store.dart';
import 'package:diario_de_habitos/confirmar_exclusao.dart';

class Habito {
  final String nome;
  final String meta;
  final IconData icone;
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
