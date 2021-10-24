import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_estagio/views/widgets/PerfilCustomizado.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  String nome = "";
  String cpf = "";

  _readDados() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios").doc(usuarioLogado!.uid).get().then((value) {
      nome = value.data()!["nome"];
      cpf = value.data()!["cpf"];
    });
  }

  Future _verificarUsuarioLogado() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    if (usuarioLogado == null) {
      Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
    } else {
      await _readDados();
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
        title: Text("Perfil"),
      ),
      body: PerfilCustomizado(
        nome: nome,
        cpf: cpf,
      ),
    );
  }
}
