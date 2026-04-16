import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

class Sobre extends StatelessWidget {
  const Sobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.info,
                size: 80,
              ),

              const SizedBox(height: 20),

              const Text(
                'Meu App de Tarefas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Aplicativo desenvolvido para gerenciamento de tarefas diárias.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              const Text(
                'Desenvolvido por: Samira da Silva Santos Pedreira',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              const Text(
                'Curso: Análise e Desenvolvimento de Sistemas',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              const Text(
                'Disciplina: Programação Mobile',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 10),

              const Text(
                'Professor: Rodrigo Plotze',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              const Text(
                'Versão 1.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}