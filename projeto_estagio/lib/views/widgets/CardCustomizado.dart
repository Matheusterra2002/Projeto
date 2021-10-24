import 'package:flutter/material.dart';

class CardCustomizado extends StatelessWidget {
  final String name;
  final String imgPath;
  final String showmore;
  final Color cor;
  final String rota;
  final Alignment alinhamento;
  final BuildContext context;

  CardCustomizado(
      {required this.name,
      required this.imgPath,
      required this.showmore,
      required this.rota,
      required this.cor,
      required this.alinhamento,
      required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, rota);
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
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width / 2.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imgPath),
                        fit: BoxFit.contain,
                        alignment: alinhamento),
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(top: 2),
              ),
              Text(
                name,
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
