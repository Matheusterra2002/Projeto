import 'package:flutter/material.dart';

class NoticiaDetalhes extends StatelessWidget {
  final String titulo;
  final String img;
  final String descricao;
  final Alignment alinhamento;
  final String data;

  NoticiaDetalhes(
      {required this.titulo,
      required this.img,
      required this.descricao,
      required this.alinhamento,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              img,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(titulo,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 15, bottom: 10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                descricao,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                "publicado em: " + data,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
          )
        ],
      ))),
    );
  }
}
