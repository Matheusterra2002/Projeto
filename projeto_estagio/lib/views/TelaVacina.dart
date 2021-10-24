import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelaVacina extends StatefulWidget {
  const TelaVacina({Key? key}) : super(key: key);

  @override
  _TelaVacinaState createState() => _TelaVacinaState();
}

class _TelaVacinaState extends State<TelaVacina> {
  FirebaseFirestore firestoreService = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacinas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.collection('vacinas').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return new SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                    child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return new CheckboxListTile(
                        title: Text(document['nome']),
                        activeColor: Colors.green,
                        value: document['tomou'],
                        onChanged: (bool? valor) {
                          setState(() {
                            firestoreService
                                .collection('vacinas')
                                .doc(document.id)
                                .update({"tomou": valor});

                            firestoreService
                                .collection('usuarios')
                                .doc(auth.currentUser!.uid)
                                .update({
                              '${document['nome']}': document['tomou'],
                            });
                          });
                        });
                  }).toList(),
                )),
                RaisedButton(
                    child: Text(
                      "Avançar",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/", (route) => false);
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
