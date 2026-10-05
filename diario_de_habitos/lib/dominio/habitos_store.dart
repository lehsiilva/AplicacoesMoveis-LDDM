import 'package:diario_de_habitos/dados/habitos_repositorio.dart';
import 'package:diario_de_habitos/dominio/habito.dart';
import 'package:flutter/foundation.dart';

class HabitosStore extends ChangeNotifier {
  HabitosStore(this._repo);

  final HabitosRepositorio _repo;
  List<Habito> _habitos = [];

  List<Habito> get habitos => List.unmodifiable(_habitos);

  Future<void> carregar() async {
    _habitos = await _repo.carregar();
    notifyListeners();
  }

  Future<void> adicionar(Habito h) async {
    await _repo.salvar(h);
    _habitos = await _repo.carregar();
    notifyListeners();
  }

  Future<void> remover(Habito h) async {
    await _repo.remover(h);
    _habitos = await _repo.carregar();
    notifyListeners();
  }

}
