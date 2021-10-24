import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:projeto_estagio/Models/Usuario.dart';
import 'package:projeto_estagio/views/widgets/BotaoCustomizado.dart';

import 'widgets/InputCustomizado.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerDataNasc = TextEditingController();
  String _mensagemErro = "";
  bool valido = false;
  bool usuarioAntigo = false;

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      //redireciona para tela principal
      _salvarDados();
      Navigator.pushNamedAndRemoveUntil(
          context, "/CadastroVacina", (route) => false);
      //Navigator.pushReplacementNamed(context, "/");
    });
  }

  _validarDataNacimento() {
    String dataNascimento = _controllerDataNasc.text;
    int dia = int.parse(dataNascimento[0] + dataNascimento[1]);
    int mes = int.parse(dataNascimento[3] + dataNascimento[4]);
    int ano = int.parse(dataNascimento[6] +
        dataNascimento[7] +
        dataNascimento[8] +
        dataNascimento[9]);
    if (ano >= 1921 && ano <= 2021) {
      if (mes > 0 && mes <= 12) {
        if (dia > 0 && dia <= 31) {
          valido = true;
        }
      }
    }

    return valido;
  }

  _salvarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection('usuarios').doc(auth.currentUser!.uid).set({
      'email': _controllerEmail.text,
      'nome': _controllerNome.text,
      'cpf': _controllerCpf.text
    });
  }

  _validarCampos() async {
    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    String cpf = _controllerCpf.text;
    String dataNasc = _controllerDataNasc.text;
    String nome = _controllerNome.text;

    await _readDados();
    if (usuarioAntigo == false) {
      if (email.isNotEmpty && email.contains("@")) {
        if (cpf.isNotEmpty && GetUtils.isCpf(cpf)) {
          _validarDataNacimento();
          if (dataNasc.isNotEmpty && valido != false) {
            if (senha.isNotEmpty && senha.length > 6) {
              if (nome.isNotEmpty) {
                Usuario usuario = Usuario();
                usuario.email = email;
                usuario.senha = senha;
                usuario.cpf = cpf;
                usuario.dataNascimento = dataNasc;
                _cadastrarUsuario(usuario);
              } else {
                setState(() {
                  _mensagemErro = "Por favor digite seu nome";
                });
              }
            } else {
              setState(() {
                _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
              });
            }
          } else {
            setState(() {
              _mensagemErro = "Preencha a data de nascimento corretamente";
            });
          }
        } else {
          setState(() {
            _mensagemErro = "CPF inválido";
          });
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha o E-mail válido";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Usuário já cadastrado";
      });
    }
  }

  _readDados() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final snapshot = await db.collection('usuarios').get();
    snapshot.docs.forEach((doc) {
      if (doc.data()['cpf'] == _controllerCpf.text ||
          doc.data()['email'] == _controllerEmail.text) {
        usuarioAntigo = true;
      }
    });
    return usuarioAntigo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFF9370DB), const Color(0xFF00BFFF)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 400,
                    height: 400,
                  ),
                ),
                InputCustomizado(
                  controller: _controllerNome,
                  hint: "Nome completo",
                  autofocus: true,
                  type: TextInputType.name,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                InputCustomizado(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                TextField(
                  controller: _controllerCpf,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "CPF",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                TextField(
                  controller: _controllerDataNasc,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Data de Nascimento",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                ),
                InputCustomizado(
                    controller: _controllerSenha, hint: "Senha", obscure: true),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                BotaoCustomizado(
                    texto: "Cadastrar-se",
                    onPressed: () {
                      _validarCampos();
                    }),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _mensagemErro,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
