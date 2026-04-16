import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_styles.dart';
import 'package:flutter_application_1/loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  final Function(String, String) onRegister;

  const RegisterScreen({super.key, required this.onRegister});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  bool emailValido(String email) {
    return email.contains('@') && email.contains('.');
  }

  void cadastrar() {
    String nome = nomeController.text.trim();
    String email = emailController.text.trim();
    String telefone = telefoneController.text.trim();
    String senha = senhaController.text;
    String confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        telefone.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      mostrarErro('Preencha todos os campos');
      return;
    }

    if (!emailValido(email)) {
      mostrarErro('Email inválido');
      return;
    }

    if (senha != confirmarSenha) {
      mostrarErro('As senhas não coincidem');
      return;
    }

    widget.onRegister(email, senha);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cadastro realizado com sucesso!'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void mostrarErro(String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
  child: Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        const Text(
          'ToDo',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 97, 117, 228),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'YOU !',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 73, 97, 231),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Bora criar sua conta!',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF3F51B5),
          ),
        ),
        const SizedBox(height: 45),
        LoginField(
          hintText: 'Insira seu E-mail',
          controller: emailController,
        ),
        const SizedBox(height: 18),
        LoginField(
          hintText: 'Nome Completo',
          controller: nomeController,
        ),
        const SizedBox(height: 18),
        LoginField(
          hintText: 'Telefone',
          controller: telefoneController,
        ),
        const SizedBox(height: 18),
        LoginField(
          hintText: 'Senha',
          controller: senhaController,
          obscureText: true,
        ),
        const SizedBox(height: 18),
        LoginField(
          hintText: 'Confirme sua senha',
          controller: confirmarSenhaController,
          obscureText: true,
        ),
        const SizedBox(height: 35),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: cadastrar,
            child: const Text(
              'Cadastrar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text(
            'Já tem conta? Entrar',
            style: TextStyle(
              color: Color(0xFF3F51B5),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  ),
),
    )
    );
}
}