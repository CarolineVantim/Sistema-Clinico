Sistema Clínico

Visão Geral do Projeto
O Sistema Clínico é uma aplicação desenvolvida em Flutter especificamente para a instituição Inclusivamente, que trabalha com crianças com deficiência física/motora. A ferramenta tem como foco principal centralizar as informações dos atendimentos e permitir o anexo de vídeos e fotos dos serviços prestados, possibilitando que os pais acompanhem de perto o progresso e o desenvolvimento de seus filhos. O projeto foca no frontend, oferecendo funcionalidades como login, visualização de dashboard, criação de novos atendimentos, gestão de pacientes e agendamentos. A comunicação com o backend será realizada através de uma API externa.

Funcionalidades Principais

Autenticação de Usuário: Sistema de login seguro.Dashboard Intuitivo: Tela inicial com navegação rápida para as principais funcionalidades.Gestão de Atendimentos:Criação de novos registros de atendimento com detalhes como cliente (CPF), título, profissional (CRM), data, horário, disciplina e observações.Campos de formulário padronizados e reutilizáveis.Gestão de Clientes/Pacientes: Funcionalidades para buscar e interagir com dados de pacientes.Gestão de Agendamentos: Visualização e gerenciamento de agendamentos.Configurações: Acesso a configurações do aplicativo.Logout: Funcionalidade segura para sair da aplicação.Notificações: Indicadores de novas notificações no dashboard.Tecnologias UtilizadasFrontend (Flutter)Flutter: Framework UI para construção de aplicativos compilados nativamente para mobile, web e desktop a partir de uma única base de código.Riverpod: Gerenciamento de estado reativo e eficiente.Dio: Cliente HTTP poderoso para requisições de rede.Shared Preferences: Armazenamento de dados simples (preferências de usuário, token JWT) localmente.flutter_svg: Para renderização de imagens no formato SVG.flutter_dotenv: Para gerenciar variáveis de ambiente (ex: API_LINK).intl: Para formatação e internacionalização de datas e horários.Widgets Reutilizáveis:CustomTextFormFieldDateTimePickerFieldCustomDropdownFieldPrimaryButtonSecondaryButtonComo Iniciar o ProjetoSiga os passos abaixo para configurar e executar o projeto em seu ambiente local.Pré-requisitosFlutter SDK: Instruções de instalaçãoIDE: IntelliJ IDEA (com plugins Flutter), VS Code (com plugins Flutter), ou outra de sua preferência.API Backend: Uma instância da API backend deve estar rodando e acessível.1. Configuração do Frontend (Aplicativo Flutter)Clone o Repositório:git clone git@github.com:CarolineVantim/Sistema-Clinico.git
cd sistema_clinico # Ou o nome da pasta do seu frontend

Instalar Dependências:flutter pub get

Configurar Variáveis de Ambiente (.env):Crie um arquivo .env na raiz do seu projeto Flutter.Defina o link da sua API backend. Use o IP real da sua máquina host ou 10.0.2.2 para emuladores Android.API_LINK=http://192.168.1.XXX:8080/api # Substitua pelo IP real da sua API
# OU
# API_LINK=http://10.0.2.2:8080/api # Para emulador Android que acessa localhost do host

Configurar Assets (pubspec.yaml):Certifique-se de que a seção assets no seu pubspec.yaml está configurada para incluir suas imagens, especialmente a logo SVG.flutter:
  uses-material-design: true
  assets:
    - assets/images/home/
    - assets/images/shared/ # Adicione esta linha se tiver imagens em shared

Após qualquer alteração no pubspec.yaml, execute flutter pub get novamente.Executar o Aplicativo:Conecte um dispositivo físico, inicie um emulador, ou execute no navegador (flutter run -d chrome).flutter run

UtilizaçãoLogin: Ao iniciar o aplicativo, você será direcionado para a tela de login. Insira suas credenciais válidas.Dashboard: Após o login, a tela inicial (Dashboard) apresentará opções para navegar pelas funcionalidades do sistema.Novo Atendimento: Preencha os campos do formulário para registrar um novo atendimento.Navegação: Utilize os botões e links para explorar as diferentes seções do aplicativo (Pacientes, Agendamentos, Configurações).Estrutura do Projeto (Frontend)lib/
├── features/
│   ├── appointments/         # Funcionalidades de agendamento
│   ├── home/                 # Tela inicial (dashboard)
│   ├── login/                # Tela de login
│   ├── patients/             # Gestão de pacientes
│   ├── settings/             # Configurações
│   ├── students/             # Gestão de estudantes (se houver distinção)
│   └── treatment/            # Gestão de atendimentos/serviços
│       └── presentation/
│           └── add_service.dart      # Tela de adicionar novo atendimento
│           └── treatment_description_page.dart
│           └── service_detail_page.dart
├── services/                 # Clientes de API (ex: api_service.dart)
├── shared/
│   ├── constants/            # Constantes, enums (ex: api_constants.dart, constants.dart)
│   ├── data/                 # Modelos e providers (ex: atendimento_model.dart, atendimento_provider.dart)
│   └── widgets/              # Componentes UI reutilizáveis (custom_text_form_field.dart, etc.)
└── main.dart                 # Ponto de entrada do aplicativo e definição de rotas

ContribuindoSe você deseja contribuir para este projeto, por favor, siga estas etapas:Faça um fork do repositório.Crie uma nova branch (git checkout -b feature/sua-feature).Faça suas alterações e commit-as (git commit -m 'feat: Adiciona nova funcionalidade X').Envie para a branch original (git push origin feature/sua-feature).Crie um Pull Request.LicençaEste projeto está licenciado sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.ContatoPara dúvidas ou sugestões, entre em contato com:Seu Nome/Nome da EquipeSeu Email/Email da EquipeLink do Projeto/Repositório (se aplicável)