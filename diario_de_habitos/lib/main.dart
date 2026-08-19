import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaHabitos(futuro: carregarHabitos())));
}

class Habito {
  final String nome;
  final String meta;
  final IconData icone;

  Habito(this.nome, this.meta, this.icone);
}

Future<List<Habito>> carregarHabitos() async {
  // simula a demora de um banco de dados ou de um servidor
  await Future.delayed(const Duration(seconds: 4));
  return [
    Habito('Beber água', 'Meta: 8 copos por dia', Icons.local_drink),
    Habito('Ler', 'Meta: 20 páginas por dia', Icons.menu_book),
    Habito('Caminhar', 'Meta: 30 minutos por dia', Icons.directions_walk),
    Habito('Dormir cedo', 'Meta: antes das 23h', Icons.bedtime),
  ];
}

class TelaHabitos extends StatelessWidget {
  const TelaHabitos({super.key, required this.futuro});

  final Future<List<Habito>> futuro;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Meus Hábitos')),
    body: FutureBuilder<List<Habito>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Não foi possível carregar'));
        }
        final habitos = snapshot.data!;
        if (habitos.isEmpty) {
          return const Center(child: Text('Nenhum hábito ainda'));
        }
        return ListView(
          children: [
            for (final h in habitos)
              ListTile(
                leading: Icon(h.icone),
                title: Text(h.nome),
                subtitle: Text(h.meta),
              ),
          ],
        );
      },
    ),
  );
}
