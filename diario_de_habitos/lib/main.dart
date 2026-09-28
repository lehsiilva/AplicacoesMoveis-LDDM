import 'package:diario_de_habitos/dados/habitos_repositorio.dart';
import 'package:diario_de_habitos/dominio/habitos_store.dart';
import 'package:diario_de_habitos/ui/tela_detalhe.dart';
import 'package:diario_de_habitos/ui/tela_novo_habito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitosStore(HabitosRepositorio())..carregar(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 118, 26, 67),
          ),
          useMaterial3: true,
        ),
        home: const TelaHabitos(),
      ),
    ),
  );
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
                    confirmDismiss: (_) => showDialog<bool>(
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
                    ),
                    onDismissed: (_) =>
                        context.read<HabitosStore>().remover(h),
                    child: ListTile(
                      leading: Icon(h.icone),
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