import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // The principal API URL
  static const String apiBaseUrl = '';
  // The Token of your API
  static const String authToken = '';

  // Headers to not specifier in every functions
  static Map<String, String> getHeaders() {
    return {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-auth-token': authToken,
    };
  }

  // Key for Snackbar doesn't depeding of Buildcontext
  void mostrarSnackBar(BuildContext context, String mensagem,
      {int duracao = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(mensagem)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      padding: const EdgeInsets.all(8),
      duration: Duration(seconds: duracao),
    ));
  }

  // Here start the API
  Future<void> sendData(
      String name,
      String email,
      String senha,
      String telefone,
      String cpf,
      bool enviarMensagem_,
      BuildContext context) async {
    final apiCadastroUrl = Uri.parse(apiBaseUrl);
    final headers = getHeaders();

    final dadosAluno = {
      'anotacoes': '',
      'telefone': telefone,
      'data_cadastro': '',
      'status': '1',
      'permissao_id': '',
      'tipo': '1',
      'senha': senha,
      'nome': name,
      'notificar': '',
      'personalizado': '',
      'email': email,
    };

    try {
      final response =
          await http.post(apiCadastroUrl, headers: headers, body: dadosAluno);

      if (response.statusCode == 200) {
        // Get the response
        final respostaJson = jsonDecode(response.body);
        // Get the alunoId to continue our algorithm
        final alunoId = respostaJson['data']['aluno_id'];
        mostrarSnackBar(context, "Usuário criado com sucesso!");

        // Call the update registration void
        await _atualizarCad(alunoId.toString(), cpf, headers, enviarMensagem_,
            email, name, telefone, senha, context);
      } else if (response.statusCode == 409) {
        // This status Code is when User has an account on platform
        // so we verirify if exist an account with that email.
        await _verificarUsuarioExistente(email, headers, name, telefone, cpf,
            senha, enviarMensagem_, context);
      } else {
        mostrarSnackBar(
            context, "Erro ao enviar dados: ${response.statusCode}");
        log("Resposta: ${response.body}");
      }
    } catch (e) {
      mostrarSnackBar(context, "Erro ao fazer requisição: $e");
    }
  }

  Future<void> _atualizarCad(
      String alunoId,
      String cpf,
      Map<String, String> headers,
      bool enviarMensagem_,
      String email,
      String nome,
      String telefone,
      String senha,
      BuildContext context) async {
    final apiAtualizarUrl = Uri.parse('$apiBaseUrl/$alunoId');
    final dadosAtualizar = {'cpf': cpf};

    try {
      if (enviarMensagem_) {
        await _enviarMensagem(email, nome, telefone, cpf, senha, context);
      }
      final response = await http.put(apiAtualizarUrl,
          headers: headers, body: dadosAtualizar);
      if (response.statusCode == 200) {
        mostrarSnackBar(context, "Cadastro atualizado com sucesso.");
      } else {
        log("Erro ao atualizar cadastro: ${response.statusCode}");
      }
    } catch (e) {
      log("Erro ao atualizar cadastro: $e");
    }
  }

  Future<void> _verificarUsuarioExistente(
      String email,
      Map<String, String> headers,
      String name,
      String telefone,
      String cpf,
      String senha,
      bool enviarMensagem_,
      BuildContext context) async {
    // The verification API URL
    final apiVerificarUser = Uri.https(
        'ead.autoescolaonline.net', '/api/1/student', {'email': email});

    try {
      final verificado = await http.get(apiVerificarUser, headers: headers);
      if (verificado.statusCode == 200) {
        // Return a list of users
        final respostaJson = jsonDecode(verificado.body);
        if (respostaJson is List) {
          // If the user was found, updated registration
          final alunoEncontrado = respostaJson.firstWhere(
              (aluno) => aluno['email'] == email,
              orElse: () => null);
          if (alunoEncontrado != null) {
            final alunoId = alunoEncontrado['aluno_id'];
            final apiAtualizarUserUrl = Uri.parse('$apiBaseUrl/$alunoId');

            final dadosAtualizar = {
              'email': email,
              'nome': name,
              'telefone': telefone,
              'cpf': cpf,
              'senha': senha,
            };

            try {
              if (enviarMensagem_) {
                await _enviarMensagem(
                    email, name, telefone, cpf, senha, context);
              }
              final response = await http.put(apiAtualizarUserUrl,
                  headers: headers, body: dadosAtualizar);
              if (response.statusCode != 200) {
                mostrarSnackBar(context,
                    "Erro ao atualizar usuário existente: ${response.statusCode}");
                return;
              }
              return mostrarSnackBar(
                  context, "Usuário existente atualizado com sucesso.");
            } catch (e) {
              mostrarSnackBar(
                  context, "Erro ao atualizar usuário existente: $e");
            }
          }
        }
      }
    } catch (e) {
      mostrarSnackBar(context, "Erro ao verificar usuário: $e");
    }
  }

  // Function to send Messages with the ChatGuru API
  Future<void> _enviarMensagem(String email, String nome, String telefone,
      String cpf, String senha, BuildContext context) async {
    final text = """
Para acessar siga sempre este passo a passo:

Clique no link 👇👇👇
https://ead.autoescolaonline.net/login

Coloque seu e-mail: 
$email

Senha: *$senha*
""";
    const key = '';
    const accountId = '';
    const phoneId = '';
    const dialogId = '';

    const headers = <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json'
    };

    final apiCgMessageUrl = Uri.parse(
        'https://s19.chatguru.app/api/v1?key=$key&account_id=$accountId&phone_id=$phoneId&chat_number=$telefone&action=message_send&text=$text');
    final apiCgDialogoUrl = Uri.parse(
        'https://s19.chatguru.app/api/v1?key=$key&account_id=$accountId&phone_id=$phoneId&chat_number=$telefone&action=dialog_execute&dialog_id=$dialogId');
    final apiChFieldUpUrl = Uri.parse(
        'https://s19.chatguru.app/api/v1?key=$key&account_id=$accountId&phone_id=$phoneId&chat_number=$telefone&action=chat_update_custom_fields&field__CPF=$cpf&field__Nome=$nome&field__Email=$email&field__Senha=$senha');

    final requests = [
      http.post(apiCgMessageUrl, headers: headers),
      (http.post(apiCgDialogoUrl, headers: headers)),
      (http.post(apiChFieldUpUrl, headers: headers))
    ];

    try {
      final response =
          await Future.wait(requests); //faz tudo de uma vez, e agiliza o trampo

      if (response[0].statusCode == 200) {
        mostrarSnackBar(context, "Mensagem enviada!");
      } else {
        mostrarSnackBar(
            context, "Mensagem não enviada! ${response[0].statusCode}");
      }

      if (response[1].statusCode == 200) {
        mostrarSnackBar(context, "Dialogo enviado!");
      } else {
        mostrarSnackBar(
            context, "Dialogo não enviado! ${response[1].statusCode}");
      }

      if (response[2].statusCode == 200) {
        mostrarSnackBar(context, "Concluido.");
      } else {
        mostrarSnackBar(context, "Deu erro ${response[2].statusCode}");
      }
    } catch (e) {
      log("Error $e");
    }
  }
}
