import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_estagio/views/widgets/BotaoCustomizado.dart';

class CadastroVacina extends StatefulWidget {
  const CadastroVacina({Key? key}) : super(key: key);

  @override
  _CadastroVacinaState createState() => _CadastroVacinaState();
}

class _CadastroVacinaState extends State<CadastroVacina> {
  FirebaseFirestore firestoreService = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  _SalvarDados() async {
    FirebaseFirestore dbUser = FirebaseFirestore.instance;
    FirebaseFirestore dbVacinas = FirebaseFirestore.instance;
    FirebaseAuth auth = await FirebaseAuth.instance;
    final snapshot = await dbVacinas.collection('vacinas').get();
    snapshot.docs.forEach((element) {
      dbUser
          .collection('usuarios')
          .doc(auth.currentUser!.uid)
          .collection('vacinas')
          .doc()
          .set({
        'nome': element.data()['nome'],
        'tomou': element.data()['tomou']
      });
    });
    snapshot.docs.forEach((doc) {
      dbVacinas.collection('vacinas').doc(doc.id).update({'tomou': false});
    });
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro de Vacinas"),
          centerTitle: true,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: new FloatingActionButton.extended(
          onPressed: () {
            _SalvarDados();
          },
          icon: Icon(Icons.navigate_next_rounded),
          label: Text(
            "Salvar",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.collection('vacinas').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Occorreu um erro');
            }

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
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return new Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1.0,
                            blurRadius: 0.2,
                          )
                        ],
                        color: Color(0xFFF5FFFA),
                      ),
                      child: CheckboxListTile(
                          title: Text(document['nome'],
                              style: TextStyle(fontSize: 20)),
                          activeColor: Colors.green,
                          value: document['tomou'],
                          onChanged: (bool? valor) {
                            setState(() {
                              firestoreService
                                  .collection('vacinas')
                                  .doc(document.id)
                                  .update({"tomou": valor});
                            });
                          })),
                );
              }).toList(),
            );
          },
        ));
  }
}
