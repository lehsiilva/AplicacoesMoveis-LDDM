import 'package:diario_de_habitos/dominio/habitos.dart';
import 'package:flutter/material.dart';
import 'ui/tela_detalhe.dart';

Future<bool> confirmarExclusao(BuildContext context, Habito h) async {
  final resultado = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Excluir hábito?'),
      content: Text('"${h.nome}" será removido da lista.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Excluir'),
        ),
      ],
    ),
  );
  return resultado ?? false;
}