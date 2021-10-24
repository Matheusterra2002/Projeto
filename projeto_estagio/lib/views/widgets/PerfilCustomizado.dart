import 'package:flutter/material.dart';

class PerfilCustomizado extends StatelessWidget {
  final String nome;
  final String cpf;

  PerfilCustomizado({
    required this.nome,
    required this.cpf,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          )))
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
