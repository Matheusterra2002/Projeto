import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_estagio/Models/Usuario.dart';
import 'package:projeto_estagio/views//widgets/inputCUstomizado.dart';
import 'package:projeto_estagio/views/widgets/BotaoCustomizado.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future _verificarUsuarioLogado() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    if (usuarioLogado != null) {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  String _mensagemErro = "";

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      //redireciona para tela principal
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    });
  }

  _validarCampos() {
    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        //Configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFFFFC855), const Color(0xFF00BFFF)],
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
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 400,
                    height: 400,
                  ),
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
                InputCustomizado(
                    controller: _controllerSenha, hint: "Senha", obscure: true),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                BotaoCustomizado(
                    texto: "Entrar",
                    onPressed: () {
                      _validarCampos();
                    }),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        "Não possui uma conta?",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        "  Cadastre-se!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(context, "/Cadastro");
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
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
