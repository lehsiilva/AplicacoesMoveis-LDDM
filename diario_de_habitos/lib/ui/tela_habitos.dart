import 'package:diario_de_habitos/dominio/habito.dart';
import 'package:diario_de_habitos/dominio/habitos_store.dart';
import 'package:diario_de_habitos/ui/tela_novo_habito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Converte a chave neutra guardada no domínio em um ícone
IconData _iconeDe(String chave) => switch (chave) {
      'check' => Icons.check_circle_outline,
      _ => Icons.circle_outlined,
    };

Future<bool> _confirmarExclusao(BuildContext context, Habito h) async {
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

class TelaHabitos extends StatelessWidget {
  const TelaHabitos({super.key});

  void _abrirNovoHabito(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TelaNovoHabito()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habitos = context.watch<HabitosStore>().habitos;

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Hábitos')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirNovoHabito(context),
        child: const Icon(Icons.add),
      ),
      body: habitos.isEmpty
          ? const Center(child: Text('Nenhum hábito ainda'))
          : ListView(
              children: [
                for (final h in habitos)
                  Dismissible(
                    key: ObjectKey(h),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (_) => _confirmarExclusao(context, h),
                    onDismissed: (_) => context.read<HabitosStore>().remover(h),
                    child: ListTile(
                      leading: Icon(_iconeDe(h.icone)),
                      title: Text(h.nome),
                      subtitle: Text(h.meta),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TelaDetalheHabito(habito: h),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }
}

class TelaDetalheHabito extends StatelessWidget {
  const TelaDetalheHabito({super.key, required this.habito});

  final Habito habito;

  Widget _bloco(ColorScheme cores, String valor, String rotulo, double fonte) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: cores.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valor,
                style: TextStyle(
                  fontSize: fonte,
                  fontWeight: FontWeight.bold,
                  color: cores.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                rotulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: cores.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(habito.nome),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir hábito',
            onPressed: () async {
              final confirmou = await _confirmarExclusao(context, habito);
              if (!context.mounted || !confirmou) return;
              context.read<HabitosStore>().remover(habito);
              Navigator.pop(context); // volta para a lista
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO E ÍCONE
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: cores.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: cores.onPrimary,
                    child: Icon(
                      _iconeDe(habito.icone),
                      color: cores.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habito.nome,
                          style: TextStyle(
                            color: cores.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          habito.meta,
                          style: TextStyle(
                            color: cores.onPrimary.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                _bloco(
                  cores,
                  '${habito.realizadoHoje}/${habito.metaHoje}',
                  'Hoje',
                  18,
                ),
                const SizedBox(width: 8),
                _bloco(cores, '${habito.diasSeguidos}', 'Dias Seguidos', 20),
                const SizedBox(width: 8),
                _bloco(cores, '${habito.percentualMes}%', 'No Mês', 20),
              ],
            ),

            const SizedBox(height: 16),

            // SOBRE O HÁBITO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cores.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sobre esse Hábito:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cores.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    habito.descricao,
                    style: TextStyle(
                      fontSize: 14,
                      color: cores.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}