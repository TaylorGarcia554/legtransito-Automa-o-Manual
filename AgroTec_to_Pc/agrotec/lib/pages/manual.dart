import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legtransito/utils/api.dart';

class AnaliseManual extends StatefulWidget {
  const AnaliseManual({super.key, required this.title});

  final String title;

  @override
  State<AnaliseManual> createState() => AnaliseManualState();
}

class AnaliseManualState extends State<AnaliseManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: AnaliseBody(
        key: UniqueKey(),
      ),
    );
  }
}

class AnaliseBody extends StatefulWidget {
  const AnaliseBody({super.key});

  @override
  AnaliseBodyConstruction createState() => AnaliseBodyConstruction();
}

class AnaliseBodyConstruction extends State<AnaliseBody> {
  bool enviarMensagem = false;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _cpf = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void _submitFrm() async {
    String name = _name.text;
    String email = _email.text;
    String senha = _senha.text;
    String telefone = _telefone.text;
    String cpf = _cpf.text;
    bool enviarMensagem_ = enviarMensagem;

    ApiService sendData = ApiService();

    await sendData.sendData(
        name, email, senha, telefone, cpf, enviarMensagem_, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Matricular no EAD',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      const SizedBox(height: 16),
                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 500, // Definindo a largura máxima desejada
                        ),
                        child: Form(
                          key: _formkey,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              TextFormField(
                                controller: _name,
                                decoration: const InputDecoration(
                                  labelText: 'Nome',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o Nome';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _email,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _senha,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira a senha';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _telefone,
                                decoration: const InputDecoration(
                                  labelText: 'Telefone',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o Telefone';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _cpf,
                                decoration: const InputDecoration(
                                  labelText: 'CPF',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira o CPF';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Checkbox(
                                      value: enviarMensagem,
                                      activeColor: Colors.white,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          enviarMensagem = value!;
                                        });
                                      }),
                                  const Text(
                                    'Enviar Mensagem',
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate() &&
                                      _email.text !=
                                          'autoescolaonline.net@gmail.com') {
                                    _submitFrm();
                                    _email.clear();
                                    _cpf.clear();
                                    _telefone.clear();
                                    _senha.clear();
                                    _name.clear();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Email Inválido.'),
                                      duration: Duration(seconds: 3),
                                    ));
                                  }
                                },
                                style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Color(0xffB71E3F))),
                                child: const Text(
                                  "Cadastrar",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  final List<MenuOption> options;

  const MenuItems({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(options[index].title),
          onTap: options[index].onTap,
        );
      },
    );
  }
}

class MenuOption {
  final String title;
  final VoidCallback onTap;

  MenuOption({required this.title, required this.onTap});
}
