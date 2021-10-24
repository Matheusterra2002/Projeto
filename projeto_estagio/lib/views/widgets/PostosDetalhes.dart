import 'package:flutter/material.dart';
import 'package:projeto_estagio/Models/Postos.dart';

class PostosDetalhes extends StatelessWidget {
  Postos posto;
  PostosDetalhes({Key? key, required this.posto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: [
          Image.network(
            posto.foto,
            height: 250,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(top: 24, left: 24),
            child: Text(
              "Centro de Saúde",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 24),
            child: Text(
              posto.nome,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text("Endereço: " + posto.endereco),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 24, bottom: 20),
            child: Text("Telefone: " + posto.telefone),
          ),
        ],
      ),
    );
  }
}
