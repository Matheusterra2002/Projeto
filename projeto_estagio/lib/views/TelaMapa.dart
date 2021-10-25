import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'controllers/PostosController.dart';

class TelaMapa extends StatefulWidget {
  const TelaMapa({Key? key}) : super(key: key);

  @override
  _TelaMapaState createState() => _TelaMapaState();
}

final appkey = GlobalKey();

class _TelaMapaState extends State<TelaMapa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appkey,
      appBar: AppBar(
          centerTitle: true,
          title: Text("Centros de Saúde"),
          backgroundColor: Color(0xFFFFC855)),
      body: ChangeNotifierProvider<PostosController>(
        create: (context) => PostosController(),
        child: Builder(builder: (context) {
          final local = context.watch<PostosController>();
          return GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(local.lat, local.long), zoom: 18),
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: local.onMapCreated,
            markers: local.markers,
          );
        }),
      ),
    );
  }
}
