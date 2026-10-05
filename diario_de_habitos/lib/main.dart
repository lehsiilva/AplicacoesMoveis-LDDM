import 'package:diario_de_habitos/dados/habitos_repositorio.dart';
import 'package:diario_de_habitos/dominio/habitos_store.dart';
import 'package:diario_de_habitos/ui/tela_habitos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final repo = HabitosRepositorio();

  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitosStore(repo)..carregar(),
      child: const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 118, 26, 67),
        ),
        useMaterial3: true,
      ),
      home: const TelaHabitos(),
    );
  }
}