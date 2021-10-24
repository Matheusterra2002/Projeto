import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VacinasPendentes extends StatefulWidget {
  const VacinasPendentes({Key? key}) : super(key: key);

  @override
  _VacinasPendentesState createState() => _VacinasPendentesState();
}

class _VacinasPendentesState extends State<VacinasPendentes> {
  FirebaseFirestore firestoreService = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vacinas Pendentes"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService
              .collection('usuarios')
              .doc(auth.currentUser!.uid)
              .collection('vacinas')
              .where("tomou", isEqualTo: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Não há vacinas pendentes');
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
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1.0,
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
                                  .collection('usuarios')
                                  .doc(auth.currentUser!.uid)
                                  .collection('vacinas')
                                  .doc(document.id)
                                  .update({"tomou": valor});
                            });
                          }),
                    ));
              }).toList(),
            );
          },
        ));
  }
}
