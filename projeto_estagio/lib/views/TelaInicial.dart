import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_estagio/views/widgets/CardCustomizado.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<String> itensMenu = [];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Meu perfil":
        Navigator.pushNamed(context, "/PerfilUsuario");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/Login");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
  }

  Future _verificarUsuarioLogado() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    if (usuarioLogado == null) {
      itensMenu = ["Entrar / Cadastrar"];
    } else {
      itensMenu = ["Meu perfil", "Deslogar"];
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFFFC855),
        title: Text("Vacina Digital"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [const Color(0xFFFFFFFF), const Color(0xFFFFFFE0)],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CardCustomizado(
                  name: "Iformações",
                  imgPath: "imagens/Info.png",
                  showmore: "",
                  rota: "/TelaNoticia",
                  cor: Colors.white,
                  alinhamento: Alignment.topCenter,
                  context: context),
              CardCustomizado(
                  name: "Localização",
                  imgPath: "imagens/map.png",
                  showmore: "",
                  rota: "/TelaMapa",
                  cor: Colors.white,
                  alinhamento: Alignment.topCenter,
                  context: context),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CardCustomizado(
                  name: "Vacinas pendentes",
                  imgPath: "imagens/vacina_icon.png",
                  showmore: "",
                  rota: "/VacinasPendentes",
                  cor: Colors.white,
                  alinhamento: Alignment.topCenter,
                  context: context),
              CardCustomizado(
                  name: "Meu Perfil",
                  imgPath: "imagens/user.png",
                  showmore: "",
                  rota: "/PerfilUsuario",
                  cor: Colors.white,
                  alinhamento: Alignment.topCenter,
                  context: context),
            ])
          ],
        ),
      ),
    );
  }
}
