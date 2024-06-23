import 'package:facultad/widgets/drawe_list_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AsistenciaPage extends StatefulWidget {
  const AsistenciaPage({super.key});

  @override
  State<AsistenciaPage> createState() => _AsistenciaPageState();
}

class _AsistenciaPageState extends State<AsistenciaPage> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Si no está habilitado, muestra un diálogo para que el usuario lo habilite
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return;
      }
    }

    // Comprueba si el usuario ya otorgó permisos de ubicación a la aplicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Si no los ha otorgado, solicita permisos
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Si los rechaza, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permiso de ubicación denegado'),
          backgroundColor: Colors.red,
        ));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Si los permisos de ubicación están desactivados permanentemente, no se puede solicitar al usuario que los habilite nuevamente.
      // Puede abrir la configuración de la aplicación y permitir que el usuario habilite los permisos manualmente.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permiso de ubicación desactivado permanentemente'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Una vez que se hayan concedido los permisos, obtén la ubicación actual
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Asistencia')),
      drawer: const Drawer(child: DrawerListView()),
      body: Column(
        children: [
          Center(child: Text('Página de Asistencia')),
          Center(
            child: _currentPosition != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Latitud: ${_currentPosition!.latitude}'),
                      Text('Longitud: ${_currentPosition!.longitude}'),
                    ],
                  )
                : CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}
