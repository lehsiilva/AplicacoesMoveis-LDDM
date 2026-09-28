import 'package:diario_de_habitos/dominio/habitos.dart';
import 'package:diario_de_habitos/ui/tela_detalhe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../confirmar_exclusao.dart';
import '../dominio/habitos_store.dart';
import 'package:diario_de_habitos/confirmar_exclusao.dart';
import '../ui/tela_detalhe.dart';

class HabitosRepositorio {
  final List<Habito> _memoria = [];

  Future<List<Habito>> carregar() async => List.of(_memoria);

  Future<void> salvar(Habito h) async {
    _memoria.add(h);
  }

  Future<void> remove(Habito h) async {
    _memoria.remove(h);
  }
}
