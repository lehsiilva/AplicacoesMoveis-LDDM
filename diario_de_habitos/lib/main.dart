import 'package:flutter/material.dart';
import 'tela_detalhe.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 118, 26, 67)),
      useMaterial3: true,
      ),
      home: TelaHabitos(futuro: carregarHabitos()),
    ),
  );
}

Future<List<Habito>> carregarHabitos() async {
  await Future.delayed(const Duration(seconds: 4));
  return [
    Habito(
      'Beber água',
      'Meta: 8 copos por dia',
      Icons.local_drink,
      12,
      5,
      8,
      62,
      'Beber água ao longo do dia ajuda a manter a concentração e o bem-estar.',
    ),
    Habito(
      'Ler',
      'Meta: 20 páginas por dia',
      Icons.menu_book,
      7,
      15,
      20,
      75,
      'A leitura diária ajuda a desenvolver o conhecimento e a concentração.',
    ),
    Habito(
      'Caminhar',
      'Meta: 30 minutos por dia',
      Icons.directions_walk,
      5,
      20,
      30,
      54,
      'Caminhar regularmente contribui para uma rotina mais ativa.',
    ),
    Habito(
      'Dormir cedo',
      'Meta: antes das 23h',
      Icons.bedtime,
      3,
      1,
      1,
      48,
      'Manter uma rotina de sono regular contribui para o descanso e o bem-estar.',
    ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalheHabito(habito: h),
                    ),
                  );
                },
              ),
          ],
        );
      },
    ),
  );
}

