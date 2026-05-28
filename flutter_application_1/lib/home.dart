import 'package:flutter/material.dart';
import 'package:flutter_application_1/sobre.dart';
import 'package:flutter_application_1/pesquisa.dart';
import 'package:flutter_application_1/api_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController tarefaController =
      TextEditingController();

  String frase = '';

  @override
  void initState() {

    super.initState();

    carregarFrase();
  }

  @override
  void dispose() {

    tarefaController.dispose();

    super.dispose();
  }

  Future<void> carregarFrase() async {

    String novaFrase =
        await ApiService.buscarFrase();

    setState(() {

      frase = novaFrase;
    });

    await FirebaseFirestore.instance
        .collection('motivacoes')
        .add({

      'uid': FirebaseAuth.instance.currentUser!.uid,

      'frase': novaFrase,

      'data': Timestamp.now(),

      'tipo': 'motivacional',

      'origem': 'API',
    });
  }

  Future<void> adicionarTarefa() async {

    if (tarefaController.text.isNotEmpty) {

      await FirebaseFirestore.instance
          .collection('tarefas')
          .add({

        'titulo': tarefaController.text,

        'descricao': '',

        'prioridade': 'Média',

        'status': false,

        'data': Timestamp.now(),

        'uid': FirebaseAuth.instance.currentUser!.uid,
      });

      await FirebaseFirestore.instance
          .collection('historico')
          .add({

        'uid': FirebaseAuth.instance.currentUser!.uid,

        'acao': 'Tarefa criada',

        'titulo': tarefaController.text,

        'data': Timestamp.now(),

        'tipo': 'criação',
      });

      tarefaController.clear();

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Tarefa adicionada com sucesso!',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('ToDo YOU !'),

        centerTitle: true,

        elevation: 0,

        actions: [

          IconButton(

            icon: const Icon(Icons.search),

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const PesquisaScreen(),
                ),
              );
            },
          ),

          IconButton(

            icon: const Icon(Icons.info_outline),

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const Sobre(),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 24,
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(

                'Minhas tarefas',

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5),
                ),
              ),

              const SizedBox(height: 6),

              const Text(

                'Organize seu dia com facilidade',

                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF3F51B5),
                ),
              ),

              const SizedBox(height: 20),

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(12),

                  boxShadow: const [

                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Text(

                      'Motivação do dia ✨',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F51B5),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      frase.isEmpty
                          ? 'Carregando...'
                          : frase,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Row(

                children: [

                  Expanded(

                    child: TextField(

                      controller:
                          tarefaController,

                      decoration:
                          const InputDecoration(

                        hintText:
                            'Digite uma tarefa...',
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton(

                    onPressed: adicionarTarefa,

                    style:
                        ElevatedButton.styleFrom(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),

                    child:
                        const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Expanded(

                child: StreamBuilder(

                  stream: FirebaseFirestore
                      .instance
                      .collection('tarefas')
                      .where(
                        'uid',
                        isEqualTo:
                            FirebaseAuth
                                .instance
                                .currentUser!
                                .uid,
                      )
                      .snapshots(),

                  builder: (context, snapshot) {

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {

                      return const Center(
                        child:
                            CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {

                      return const Center(

                        child: Text(

                          'Nenhuma tarefa ainda',

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    var tarefas =
                        snapshot.data!.docs;

                    return ListView.separated(

                      itemCount: tarefas.length,

                      separatorBuilder:
                          (_, __) =>
                              const SizedBox(
                                  height: 10),

                      itemBuilder:
                          (context, index) {

                        var tarefa =
                            tarefas[index];

                        return Container(

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),

                          decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                                BorderRadius
                                    .circular(10),

                            boxShadow: const [

                              BoxShadow(
                                color:
                                    Color(0x11000000),
                                blurRadius: 4,
                                offset:
                                    Offset(0, 2),
                              ),
                            ],
                          ),

                          child: ListTile(

                            contentPadding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),

                            leading: Checkbox(

                              value:
                                  tarefa['status'],

                              onChanged:
                                  (value) async {

                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                        'tarefas')
                                    .doc(
                                        tarefa.id)
                                    .update({

                                  'status':
                                      value,
                                });
                              },
                            ),

                            title: Text(

                              tarefa['titulo'],

                              style: TextStyle(

                                fontSize: 15,

                                color:
                                    const Color(
                                        0xFF3F51B5),

                                decoration:
                                    tarefa[
                                            'status']
                                        ? TextDecoration
                                            .lineThrough
                                        : TextDecoration
                                            .none,
                              ),
                            ),

                            trailing:
                                IconButton(

                              icon: const Icon(
                                Icons
                                    .delete_outline,

                                color:
                                    Color(
                                        0xFF3F51B5),
                              ),

                              onPressed:
                                  () async {

                                await FirebaseFirestore
                                    .instance
                                    .collection(
                                        'tarefas')
                                    .doc(
                                        tarefa.id)
                                    .delete();
                              },
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
      ),
    );
  }
}