<div align="center">

# Sinaliza.Ai

### Mobilidade inteligente. Cidades mais seguras.

**Informações urbanas e acessibilidade na palma da sua mão!** 🚦

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Status](https://img.shields.io/badge/Status-Protótipo%20funcional-C2286B?style=for-the-badge)

**Global Solution FIAP 2026/2 | CitizenTech**

</div>

---

## 💗 Sobre o projeto

O **Sinaliza.Ai** é um aplicativo mobile voltado à mobilidade urbana,
acessibilidade e consulta de informações demonstrativas sobre semáforos,
abrigos e alertas.

O aplicativo reúne recursos para ajudar o usuário a visualizar condições de
uma região, encontrar locais de apoio, consultar alertas e conhecer recursos
de mobilidade inclusiva.

Desenvolvido para a **Global Solution FIAP 2026/2 — CitizenTech**, o projeto
busca apresentar uma experiência simples, acessível e centralizada para
informações relacionadas à mobilidade urbana.

> **Protótipo funcional:** esta versão concentra-se na interface, navegação,
> formulários, gerenciamento de estado, autenticação local e interações com
> dados demonstrativos.

---

## 🎯 Nosso objetivo

Contribuir para uma mobilidade urbana mais informada e inclusiva.

Com o Sinaliza.Ai, queremos:

- 🚦 Facilitar a consulta de semáforos e condições do trânsito.
- 🗺️ Reunir informações urbanas em um mapa interativo.
- 🏠 Ajudar na localização demonstrativa de abrigos.
- ⚠️ Organizar alertas por categoria e nível de atenção.
- ♿ Apresentar recursos de acessibilidade e rotas inclusivas.
- 👤 Oferecer uma experiência personalizada com conta e preferências locais.

---

## 📱 Funcionalidades

O protótipo apresenta as seguintes funcionalidades:

| Funcionalidade | Descrição |
|---|---|
| 🔐 Cadastro e Login | Criação de contas locais, validações e autenticação persistente no dispositivo. |
| 🏠 Home | Acesso rápido às áreas de Mapa, Abrigos, Alertas e Acessibilidade. |
| 🗺️ Mapa | Visualização demonstrativa de semáforos e abrigos com seleção de marcadores. |
| 🚦 Detalhes do Semáforo | Status, fluxo, endereço e informações demonstrativas do ponto selecionado. |
| 🏠 Abrigos | Listagem, filtros, favoritos e detalhes de abrigos demonstrativos. |
| ⚠️ Alertas | Consulta e filtro de alertas por enchentes, trânsito e manutenção. |
| 📄 Detalhes do Alerta | Visualização das informações do alerta selecionado. |
| ♿ Acessibilidade | Conteúdos sobre rotas com rampas, semáforos sonoros e calçadas acessíveis. |
| 👤 Perfil | Dados do usuário, preferências, páginas internas e logout. |
| 📷 Foto de perfil | Seleção de uma imagem local da galeria do dispositivo. |
| 🔔 Preferências | Ativação local da preferência de notificações demonstrativas. |

### 🚦 Mobilidade e mapa

O mapa permite alternar entre semáforos e abrigos, selecionar marcadores e
abrir detalhes do item correspondente.

As posições e informações exibidas são mockadas e servem para demonstrar a
experiência de navegação. Não representam dados oficiais ou monitoramento em
tempo real.

### ♿ Acessibilidade

A área de Acessibilidade apresenta conteúdos informativos sobre:

- Rotas com rampas.
- Semáforos sonoros.
- Calçadas acessíveis.

As páginas são educativas e não calculam rotas nem confirmam a acessibilidade
real de um local.

---

## 🛠️ Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| **Flutter** | Desenvolvimento da interface mobile. |
| **Dart** | Linguagem de programação. |
| **Material Design 3** | Componentes visuais e interações. |
| **Google Fonts** | Uso da tipografia DM Sans. |
| **flutter_secure_storage** | Armazenamento local seguro de contas e sessão. |
| **crypto** | Geração de hash com salt para as senhas locais. |
| **image_picker** | Seleção de foto de perfil no dispositivo. |
| **flutter_test** | Testes automatizados do aplicativo. |

---

## 🚀 Como executar o projeto

### Pré-requisitos

Antes de começar, tenha instalado:

- Flutter SDK configurado.
- Dart SDK, incluído no Flutter.
- Android Studio ou ambiente compatível.
- Emulador Android ou dispositivo físico.

### 1. Obtenha o projeto

Clone o repositório ou faça o download dos arquivos do projeto.

### 2. Instale as dependências

Na pasta raiz do projeto, execute:

~~~bash
flutter pub get
~~~

### 3. Execute o aplicativo

Com um emulador ou dispositivo conectado:

~~~bash
flutter run
~~~

Para visualizar os dispositivos disponíveis:

~~~bash
flutter devices
~~~

### 4. Execute as verificações

Análise estática:

~~~bash
flutter analyze
~~~

Testes automatizados:

~~~bash
flutter test
~~~

---

## 🔑 Acesso local

Esta versão não utiliza API, servidor ou banco de dados externo.

Para acessar o aplicativo:

1. Abra a Splash Screen.
2. Toque em **Começar**.
3. Selecione **Cadastre-se** na tela de Login.
4. Crie uma conta com nome, e-mail e senha.
5. Retorne ao Login e use as credenciais cadastradas.

Não existe uma conta predefinida ou senha fixa no aplicativo.

As contas são armazenadas localmente. O login só permite acesso com uma conta
criada anteriormente pelo usuário. O logout encerra a sessão, mas preserva a
conta para um novo login.

> A autenticação é local e demonstrativa. Ela não oferece as mesmas garantias
> de um serviço real com API, servidor, tokens e validação remota.

---

## 🧪 Testes e validação

Os testes automatizados verificam cenários como:

- Cadastro com campos inválidos.
- Aceite obrigatório dos termos.
- Login com credenciais cadastradas.
- Rejeição de credenciais incorretas.
- Bloqueio de e-mails duplicados.
- Normalização de e-mails.
- Restauração e encerramento de sessão.
- Navegação entre as cinco áreas principais.
- Abertura do card de Alertas.
- Filtros de alertas.
- Seleção de semáforos no mapa.
- Exibição do card do ponto selecionado.

Os testes estão organizados em:

- test/widget_test.dart
- test/local_auth_service_test.dart

---

## 🎬 Vídeo de apresentação


---

## 👩‍💻 Equipe de desenvolvimento

| Integrante | RM |
|---|---|
| Julia Valerio Guimarães da Silva | 568275 |
| Ruan Lima da Silva | 566719 |
| Rhayssa Graziano Bernardes e Rocha Ferreira | 567549 |

---

## 🔮 Próximas etapas

Entre as evoluções possíveis estão:

- Integração com a API Java.
- Persistência em banco de dados remoto.
- Validação de sessão por tokens.
- Atualização de trânsito e alertas em tempo real.
- Notificações push.
- Busca real de rotas acessíveis.
- Geolocalização e busca externa de endereços.
- Recuperação de senha.
- Sincronização de dados entre dispositivos.

Esses recursos não estão implementados integralmente nesta versão.

---

<div align="center">

### Sinaliza.Ai

**Mobilidade inteligente, cidades mais seguras.**

*Desenvolvido como projeto acadêmico para a Global Solution FIAP 2026/2.*

</div>
