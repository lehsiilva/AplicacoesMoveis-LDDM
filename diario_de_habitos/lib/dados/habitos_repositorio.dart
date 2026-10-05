import 'package:diario_de_habitos/dominio/habito.dart';

class HabitosRepositorio {
  final List<Habito> _memoria = [];

  Future<List<Habito>> carregar() async => List.of(_memoria);

  Future<void> salvar(Habito h) async {
    _memoria.add(h);
  }

  Future<void> remover(Habito h) async {
    _memoria.remove(h);
  }
}