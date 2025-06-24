import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_clinico/services/api_service.dart'; // Certifique-se que este caminho está correto
import 'package:sistema_clinico/main.dart'; // Para acessar a classe Routes
import 'package:sistema_clinico/shared/constants/constants.dart'; // Para o enum ImageResourceEnum
import 'package:dio/dio.dart'; // Importa DioException para tratamento de erro mais específico

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // --- Controladores e Variáveis de Estado para a Lógica de Login ---
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Para validação de formulário

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Lógica de Login ---
  void _login() async {
    // Valida os campos do formulário antes de prosseguir
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final usernameInput =
        _usernameController.text; // Captura o username digitado
    final password = _passwordController.text;

    try {
      print("DEBUG_LOGIN: Tentando autenticar com a API...");
      // Chama o ApiClient passando o username digitado
      final response =
          await ApiClient().authAuthenticate(usernameInput, password);
      print("DEBUG_LOGIN: Resposta da API recebida.");
      print(
          "DEBUG_LOGIN: Dados da Resposta do ApiClient: $response"); // Este print mostrará o novo formato

      // O ApiClient agora retorna um Map que já garante a presença de 'token', 'userType' e 'username'
      // Se essas chaves não estivessem presentes, uma exceção já teria sido lançada pelo ApiClient.
      final String token = response['token'];
      final String userType = response['userType'];
      final String usernameRetornado =
          response['username']; // Pega o username que o ApiClient retornou

      // Salvando os dados nas SharedPreferences
      prefs.setString("token", token);
      prefs.setString(
          "username", usernameRetornado); // Salva o username retornado
      prefs.setString("userType", userType);

      print(
          "DEBUG_LOGIN: Autenticação bem-sucedida. Token, UserType e Username salvos.");
      print(
          "DEBUG_LOGIN: Usuário logado: $usernameRetornado (Tipo: $userType)");
      print("DEBUG_LOGIN: Token recebido: $token");

      // --- VERIFICAÇÃO DE CONTEXTO E NAVEGAÇÃO ---
      print(
          "DEBUG_LOGIN: Status mounted antes da navegação: ${context.mounted}");

      if (!mounted) {
        print("DEBUG_LOGIN: Widget não está montado, não é possível navegar.");
        return;
      }

      print(
          "DEBUG_LOGIN: Antes de tentar navegar para /home (usando rota nomeada)");
      Navigator.pushReplacementNamed(context, Routes.home);
      print(
          "DEBUG_LOGIN: Depois de tentar navegar para /home (se a chamada foi concluída)");
    } catch (e) {
      // Tratamento de erros que podem vir do Dio ou da validação interna do ApiClient
      String errorMessage = 'Não foi possível fazer login. Tente novamente.';
      if (e.toString().contains('401')) {
        errorMessage = 'Credenciais incorretas.';
      } else if (e.toString().contains('403')) {
        errorMessage = 'Acesso negado. Verifique suas permissões.';
      } else if (e.toString().contains('Estrutura de dados inválida')) {
        errorMessage = 'Erro na resposta da API: ' +
            e.toString().replaceFirst('Exception: ', '');
      } else if (e is DioException) {
        // Captura DioException para mensagens mais específicas de rede
        if (e.type == DioExceptionType.connectionError) {
          errorMessage =
              'Erro de conexão: Verifique sua internet ou o servidor da API.';
        } else if (e.response != null && e.response!.data != null) {
          // Tenta extrair mensagem de erro do corpo da resposta da API, se disponível
          errorMessage = e.response!.data.toString();
        }
      }
      print("DEBUG_LOGIN: Uma exceção ocorreu durante o login: $e");
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
    // --- Definição das Cores do Layout ---
    const Color topBlueColor =
        Color(0xFFD0EDF8); // Azul pastel para a parte superior
    const Color bottomWhiteColor =
        Color(0xFFF9F7F0); // Quase branco/bege claro para o rodapé
    const Color cardBackgroundColor =
        Color(0xFFF0E5D8); // Cor do card de login (bege/rosado claro)
    const Color loginButtonColor =
        Color(0xFFB1D4E0); // Cor do botão de login (azul/cinza claro)
    const Color logoTextColor =
        Color(0xFF0083B8); // Cor do texto "Inclusivamente"

    return Scaffold(
      backgroundColor: bottomWhiteColor,
      body: Stack(
        children: [
          // --- Camada de Fundo AZUL no Topo com Borda Arredondada na Parte de Baixo ---
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

          // --- Conteúdo da Tela (Logo, Card de Login, Copyright) ---
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centraliza o conteúdo da coluna verticalmente
                children: [
                  // --- ALTERAÇÃO AQUI: REDUZINDO O FLEX DO SPACER PARA SUBIR O CONTEÚDO ---
                  const Spacer(flex: 1), // Reduzido de flex: 2 para flex: 1

                  // --- Logo e Texto "Inclusivamente" ---
                  Image.asset(
                    ImageResourceEnum.icone.path, // Usando o enum
                    height: 120, // Altura da logo, ajuste conforme necessário
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Inclusivamente',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: logoTextColor,
                    ),
                  ),

                  const SizedBox(
                      height: 20), // Espaçamento entre a logo e o card

                  // --- Card de Login ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Card(
                      color: cardBackgroundColor,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Form(
                          key: _formKey, // Atribui a GlobalKey
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // --- Campo Username ---
                              TextFormField(
                                controller:
                                    _usernameController, // Conecta o controlador
                                decoration: InputDecoration(
                                  labelText: 'Username',
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
                                  // Adiciona validação
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira seu usuário';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),

                              // --- Campo Password ---
                              TextFormField(
                                controller:
                                    _passwordController, // Conecta o controlador
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 15.0),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _passwordController
                                          .clear(); // Limpa o campo de senha
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  // Adiciona validação
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira sua senha';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),

                              // --- Texto "Esqueceu a senha?" ---
                              Align(
                                alignment: Alignment.centerRight,
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

                              // --- Botão Login (com CircularProgressIndicator) ---
                              _isLoading
                                  ? const CircularProgressIndicator() // Mostra o spinner se estiver carregando
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
                                        ),
                                        elevation: 5,
                                      ),
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
