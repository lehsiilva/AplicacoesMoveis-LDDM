import 'package:diario_de_habitos/dominio/habito.dart';
import 'package:diario_de_habitos/dominio/habitos_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({super.key});

  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _metaController = TextEditingController();
  final _metaHojeController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _metaController.dispose();
    _metaHojeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  String? _obrigatorio(String? valor, String mensagem) {
    if (valor == null || valor.trim().isEmpty) return mensagem;
    return null;
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final habito = Habito(
        _nomeController.text.trim(),
        _metaController.text.trim(),
        'check', // chave do ícone
        0, // dias seguidos
        0, // realizado hoje
        int.parse(_metaHojeController.text),
        0, // percentual do mês
        _descricaoController.text.trim(),
      );
      context.read<HabitosStore>().adicionar(habito);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Hábito')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => _obrigatorio(v, 'Informe o nome'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _metaController,
                decoration: const InputDecoration(
                  labelText: 'Meta (ex: 8 copos por dia)',
                ),
                validator: (v) => _obrigatorio(v, 'Informe a meta'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _metaHojeController,
                decoration: const InputDecoration(
                  labelText: 'Quantidade diária (número)',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Informe a quantidade diária';
                  }
                  final n = int.tryParse(v);
                  if (n == null || n <= 0) return 'Informe um número válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                validator: (v) => _obrigatorio(v, 'Informe a descrição'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}