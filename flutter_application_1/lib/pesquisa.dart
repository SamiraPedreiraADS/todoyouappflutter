import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PesquisaScreen extends StatefulWidget {
  const PesquisaScreen({super.key});

  @override
  State<PesquisaScreen> createState() =>
      _PesquisaScreenState();
}

class _PesquisaScreenState
    extends State<PesquisaScreen> {

  final pesquisaController =
      TextEditingController();

  String pesquisa = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Pesquisar tarefas'),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller: pesquisaController,

              decoration: const InputDecoration(
                hintText: 'Pesquisar tarefa...',
                prefixIcon: Icon(Icons.search),
              ),

              onChanged: (value) {

                setState(() {
                  pesquisa = value.toLowerCase();
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(

              child: StreamBuilder(

                stream: FirebaseFirestore.instance
                    .collection('tarefas')
                    .where(
                      'uid',
                      isEqualTo:
                          FirebaseAuth.instance
                              .currentUser!
                              .uid,
                    )
                    .snapshots(),

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {

                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  var tarefas =
                      snapshot.data!.docs;

                  var tarefasFiltradas =
                      tarefas.where((tarefa) {

                    String titulo =
                        tarefa['titulo']
                            .toString()
                            .toLowerCase();

                    return titulo.contains(
                        pesquisa);
                  }).toList();

                  tarefasFiltradas.sort((a, b) {

                    return a['titulo']
                        .toString()
                        .compareTo(
                            b['titulo']
                                .toString());
                  });

                  if (tarefasFiltradas.isEmpty) {

                    return const Center(
                      child: Text(
                        'Nenhuma tarefa encontrada',
                      ),
                    );
                  }

                  return ListView.builder(

                    itemCount:
                        tarefasFiltradas.length,

                    itemBuilder: (context, index) {

                      var tarefa =
                          tarefasFiltradas[index];

                      return Card(

                        child: ListTile(

                          leading: Icon(

                            tarefa['status']
                                ? Icons.check_circle
                                : Icons.circle_outlined,

                            color:
                                tarefa['status']
                                    ? Colors.green
                                    : Colors.grey,
                          ),

                          title:
                              Text(tarefa['titulo']),

                          subtitle: Text(
                            tarefa['prioridade'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}