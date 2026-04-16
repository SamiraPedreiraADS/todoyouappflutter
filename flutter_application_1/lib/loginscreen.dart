import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login_styles.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/esqueceusenha.dart';
import 'package:flutter_application_1/cadastro.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  bool emailValido(String email) {
    return email.contains('@') && email.contains('.');
  }

  void login() {
    String email = emailController.text.trim();
    String senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      mostrarErro('Preencha todos os campos');
      return;
    }

    if (!emailValido(email)) {
      mostrarErro('Email inválido');
      return;
    }

    if (email != savedEmail || senha != savedSenha) {
      mostrarErro('Email ou senha incorretos');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'ToDo',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color:  Color.fromARGB(255, 97, 117, 228),
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
                    'Bom te ver de volta!',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color:Color.fromARGB(255, 39, 54, 139),
                    ),
                  ),

                  const SizedBox(height: 60),

                  LoginField(
                    hintText: 'Insira seu E-mail',
                    controller: emailController,
                  ),

                  const SizedBox(height: 18),

                  LoginField(
                    hintText: 'Senha',
                    controller: senhaController,
                    obscureText: true,
                  ),

                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EsqueceuSenhaScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 39, 54, 139),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(
                            onRegister: (email, senha) {
                              savedEmail = email;
                              savedSenha = senha;
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Criar conta',
                      style: TextStyle(
                        color: Color.fromARGB(255, 39, 54, 139),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}