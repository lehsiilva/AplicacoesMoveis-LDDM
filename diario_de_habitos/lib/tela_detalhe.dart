import 'package:flutter/material.dart';

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

class TelaDetalheHabito extends StatelessWidget {
  const TelaDetalheHabito({super.key, required this.habito});

  final Habito habito;

  @override
  Widget build(BuildContext context) {
    // Acessa o esquema de cores dinâmico do tema
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(habito.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TÍTULO E ÍCONE
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
                    child: Image.asset('assets/imagens/copo.png', height: 35),
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
                            color: cores.onPrimary.withOpacity(0.9),
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
                //HOJE
                Expanded(
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
                            '${habito.realizadoHoje}/${habito.metaHoje}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: cores.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hoje',
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
                ),

                const SizedBox(width: 8),

                // DIAS SEGUIDOS
                Expanded(
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
                            '${habito.diasSeguidos}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: cores.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dias Seguidos',
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
                ),

                const SizedBox(width: 8),

                //NO MÊS
                Expanded(
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
                            '${habito.percentualMes}%',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: cores.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'No Mês',
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
                ),
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
