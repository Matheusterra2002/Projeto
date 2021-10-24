import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatefulWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  String nome = "";
  String cpf = "";

  Future _readDados() async {
    await Firebase.initializeApp();
    FirebaseAuth auth = await FirebaseAuth.instance;
    User? usuarioLogado = await auth.currentUser;
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("usuarios").doc(usuarioLogado!.uid).get().then((value) {
      setState(() {
        nome = value.data()!["nome"];
        cpf = value.data()!["cpf"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _readDados();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestoreService = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Meu Perfil",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                    )
                  ],
                  color: Color(0xFFDCDCDC),
                ),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 0, 20),
                        child: Image(
                          image: AssetImage("imagens/sus_icon.png"),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 10, 15),
                        child: Container(
                            width: 200,
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  nome,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start,
                                ),
                                Padding(padding: EdgeInsets.only(top: 20)),
                                Text(cpf,
                                    style: TextStyle(fontSize: 15),
                                    textAlign: TextAlign.start)
                              ],
                            ))),
                  ],
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                child: Text(
                  "Vacinas já Adquiridas",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 10, 15),
                child: Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: firestoreService
                      .collection('usuarios')
                      .doc(auth.currentUser!.uid)
                      .collection('vacinas')
                      .where("tomou", isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("SEM DADOS"),
                      );
                    }
                    return new ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return new Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1.0,
                                  )
                                ],
                                color: Color(0xFFDCDCDC),
                              ),
                              child: CheckboxListTile(
                                  title: Text(document['nome'],
                                      style: TextStyle(fontSize: 20)),
                                  activeColor: Colors.green,
                                  value: true,
                                  onChanged: (bool? valor) {}),
                            ));
                      }).toList(),
                    );
                  },
                )))
          ]),
        ),
      ),
    );
  }
}
