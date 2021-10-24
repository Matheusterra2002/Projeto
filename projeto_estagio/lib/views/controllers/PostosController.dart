import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projeto_estagio/Models/Postos.dart';
import 'package:projeto_estagio/views/TelaMapa.dart';
import 'package:projeto_estagio/views/widgets/PostosDetalhes.dart';

class PostosController extends ChangeNotifier {
  final List<Postos> _ListaPostos = [];
  late FirebaseFirestore db = FirebaseFirestore.instance;

  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  Set<Marker> markers = Set<Marker>();
  late GoogleMapController _mapsController;

  get mapsController => _mapsController;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
    loadPostos();
  }

  _readPostos() async {
    if (_ListaPostos.isEmpty) {
      final snapshot = await db.collection('Postos').get();
      snapshot.docs.forEach((doc) {
        Postos posto = Postos(
            nome: doc.data()['nome'],
            endereco: doc.data()['endereco'],
            foto: doc.data()['foto'],
            latitude: doc.data()['latitude'],
            longitude: doc.data()['longitude'],
            telefone: doc.data()['telefone']);
        _ListaPostos.add(posto);

        notifyListeners();
      });
    }
    return _ListaPostos;
  }

  loadPostos() async {
    await _readPostos();
    final postos = _ListaPostos;
    postos.forEach((posto) async {
      markers.add(Marker(
          markerId: MarkerId(posto.nome),
          position: LatLng(posto.latitude, posto.longitude),
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(), 'imagens/postos.png'),
          onTap: () => {
                showModalBottomSheet(
                    context: appkey.currentState!.context,
                    builder: (context) => PostosDetalhes(posto: posto))
              }));
    });
    notifyListeners();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }
}
