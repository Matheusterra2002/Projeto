//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:projeto_estagio/views/widgets/NoticiaDetalhes.dart';

class NoticiaCustomizada extends StatelessWidget {
  final String name;
  final String imgPath;
  final String showmore;
  final String descricao;
  final Color cor;
  final Alignment alinhamento;
  final BuildContext context;
  final String data;

  NoticiaCustomizada(
      {required this.name,
      required this.imgPath,
      required this.showmore,
      required this.descricao,
      required this.cor,
      required this.alinhamento,
      required this.context,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoticiaDetalhes(
                        titulo: name,
                        img: imgPath,
                        descricao: descricao,
                        alinhamento: alinhamento,
                        data: data,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              )
            ],
            color: cor,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 7),
              ),
              Hero(
                  tag: new Text("hero 1"),
                  child: Image.network(
                    imgPath,
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCC8053),
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  color: Color(0xFFEBEBEB),
                  height: 1.0,
                ),
              ),
              Text(
                showmore,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Varela',
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
