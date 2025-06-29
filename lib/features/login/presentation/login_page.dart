import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_clinico/services/api_service.dart';
import 'package:sistema_clinico/main.dart'; // Certifique-se de que este import está correto para o 'Routes.home'
import 'package:sistema_clinico/shared/constants/constants.dart'; // Certifique-se de que ImageResourceEnum está definido aqui
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _showClearPasswordIcon = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_updateClearPasswordIconVisibility);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updateClearPasswordIconVisibility);
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateClearPasswordIconVisibility() {
    setState(() {
      _showClearPasswordIcon = _passwordController.text.isNotEmpty;
    });
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final usernameInput = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response =
          await ApiClient().authAuthenticate(usernameInput, password);
      final String token = response['token'];
      final String userType = response['userType'];
      final String usernameRetornado = response['username'];

      prefs.setString("token", token);
      prefs.setString("username", usernameRetornado);
      prefs.setString("userType", userType);

      Navigator.pushReplacementNamed(context, Routes.home);
    } catch (e) {
      String errorMessage = 'Não foi possível fazer login. Tente novamente.';
      if (e.toString().contains('401')) {
        errorMessage = 'Credenciais incorretas.';
      } else if (e.toString().contains('403')) {
        errorMessage = 'Acesso negado. Verifique suas permissões.';
      } else if (e.toString().contains('Estrutura de dados inválida')) {
        errorMessage =
            'Erro na resposta da API: ${e.toString().replaceFirst('Exception: ', '')}';
      } else if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          errorMessage =
              'Erro de conexão: Verifique sua internet ou o servidor da API.';
        } else if (e.response != null && e.response!.data != null) {
          errorMessage = e.response!.data.toString();
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
        print("DEBUG_LOGIN: _isLoading definido como false.");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color topBlueColor = Color(0xFFD0EDF8);
    const Color bottomWhiteColor = Color(0xFFF9F7F0);
    const Color cardBackgroundColor = Color(0xFFF0E5D8);
    const Color loginButtonColor = Color(0xFFB1D4E0);
    const Color logoTextColor = Color(0xFF0083B8);

    return Scaffold(
      backgroundColor: bottomWhiteColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.80, // Altura da seção azul (80% da tela)
              decoration: const BoxDecoration(
                color: topBlueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Image.asset(
                    ImageResourceEnum.logo.path,
                    height: 100,
                  ),
                  const SizedBox(height: 20),

                  // --- Card de Login ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Card(
                      color: cardBackgroundColor,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  labelText: 'Usuário',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu usuário';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                  // Condicional para mostrar o ícone "X"
                                  suffixIcon: _showClearPasswordIcon
                                      ? IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            _passwordController.clear();
                                          },
                                        )
                                      : null,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira sua senha';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),

                              // --- Texto "Esqueceu a senha?" ---
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    // TODO: Ação de "esqueceu a senha"
                                  },
                                  child: const Text(
                                    'Esqueceu a senha?',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed:
                                          _login, // Chama a função de login
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: loginButtonColor,
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          )),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ), // Fim do Form
                      ),
                    ),
                  ),
                  // --- ESTE SPACER PERMANECE PARA EMPURRAR O COPYRIGHT PARA BAIXO ---
                  const Spacer(flex: 2),

                  // --- Copyright / Rodapé ---
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      '© 2024 Fatec Araras. Todos os direitos reservados.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
