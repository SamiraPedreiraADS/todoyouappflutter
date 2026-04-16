import 'package:flutter/material.dart';
import 'package:flutter_application_1/sobre.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController tarefaController = TextEditingController();

  List<Map<String, dynamic>> tarefas = [];

  @override
  void dispose() {
    tarefaController.dispose();
    super.dispose();
  }

  void adicionarTarefa() {
    if (tarefaController.text.isNotEmpty) {
      setState(() {
        tarefas.add({
          'titulo': tarefaController.text,
          'concluida': false,
        });
      });
      tarefaController.clear();
    }
  }

  void removerTarefa(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  void toggleTarefa(int index) {
    setState(() {
      tarefas[index]['concluida'] = !tarefas[index]['concluida'];
    });
  }

  void editarTarefa(int index) {
    TextEditingController editController =
        TextEditingController(text: tarefas[index]['titulo']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar tarefa'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Digite a nova tarefa',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tarefas[index]['titulo'] = editController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
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
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Sobre(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tarefaController,
                      decoration: const InputDecoration(
                        hintText: 'Digite uma tarefa...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: adicionarTarefa,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Expanded(
                child: tarefas.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma tarefa ainda',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: tarefas.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x11000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              leading: Checkbox(
                                value: tarefas[index]['concluida'],
                                onChanged: (value) {
                                  toggleTarefa(index);
                                },
                              ),
                              title: Text(
                                tarefas[index]['titulo'],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: const Color(0xFF3F51B5),
                                  decoration: tarefas[index]['concluida']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              onTap: () => editarTarefa(index),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFF3F51B5),
                                ),
                                onPressed: () => removerTarefa(index),
                              ),
                            ),
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