import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_estagio/views/widgets/NoticiaCustomizada.dart';

class TelaNoticia extends StatefulWidget {
  const TelaNoticia({Key? key}) : super(key: key);

  @override
  _TelaNoticiaState createState() => _TelaNoticiaState();
}

class _TelaNoticiaState extends State<TelaNoticia> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text("Princiapais notícias"),
          centerTitle: true,
          backgroundColor: Color(0xFFFFC855),
        ),
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('noticias').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((documents) {
                  return NoticiaCustomizada(
                      name: documents['titulo'],
                      imgPath: documents['foto'],
                      showmore: 'Clique para mais informações',
                      descricao: documents['descricao'],
                      cor: Colors.white,
                      alinhamento: Alignment.center,
                      data: documents['data'],
                      context: context);
                }).toList(),
              );
            }),
      ),
    );
  }
}
