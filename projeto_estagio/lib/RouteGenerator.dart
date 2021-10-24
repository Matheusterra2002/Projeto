import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_estagio/views/Cadastro.dart';
import 'package:projeto_estagio/views/TelaInicial.dart';
import 'package:projeto_estagio/views/Login.dart';
import 'package:projeto_estagio/views/PerfilUsuario.dart';
import 'package:projeto_estagio/views/TelaMapa.dart';
import 'package:projeto_estagio/views/TelaNoticia.dart';
import 'package:projeto_estagio/views/CadastroVacina.dart';
import 'package:projeto_estagio/views/VacinasPendentes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => TelaInicial());
      case "/Login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/Cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());
      case "/PerfilUsuario":
        return MaterialPageRoute(builder: (_) => PerfilUsuario());
      case "/TelaNoticia":
        return MaterialPageRoute(builder: (_) => TelaNoticia());
      case "/TelaMapa":
        return MaterialPageRoute(builder: (_) => TelaMapa());
      case "/CadastroVacina":
        return MaterialPageRoute(builder: (_) => CadastroVacina());
      case "/VacinasPendentes":
        return MaterialPageRoute(builder: (_) => VacinasPendentes());
      default:
        _erroRota();
    }
    return _erroRota();
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada"),
        ),
        body: Center(
          child: Text("Tela não encontrada"),
        ),
      );
    });
  }
}
