import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const id = "/mapscreen";
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Future<Position> getLocation() async {
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      await Geolocator.openLocationSettings();
    }
    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print("YES1");
    if (!locationServiceEnabled) return Future.error("Enable Location Service");
    print("YES2");
    LocationPermission isPermitted = await Geolocator.checkPermission();
    print(isPermitted.toString());
    if (isPermitted == LocationPermission.denied ||
        isPermitted == LocationPermission.deniedForever) {
      isPermitted = await Geolocator.requestPermission();
    }
    print(isPermitted.toString());
    if (isPermitted == LocationPermission.denied ||
        isPermitted == LocationPermission.deniedForever) {
      return Future.error("Enable location permission for app from settings");
    }
    print("YES3");
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getLocationBackground() async {
    bool locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) return null;
    LocationPermission isPermitted = await Geolocator.checkPermission();
    if (isPermitted == LocationPermission.denied ||
        isPermitted == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  Set<Marker> markers = {};
  late GoogleMapController _googleMapController;
  bool ifMapInitialized = false;
  bool toClose = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    toClose = true;
  }

  @override
  Widget build(BuildContext context) {
    Position userPosition = Position(latitude: 0,longitude: 0,timestamp: DateTime.now(),accuracy: 0,altitude: 0,heading: 0,speed: 0,speedAccuracy: 0,floor: 0,isMocked: false);
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      if (toClose == true) timer.cancel();
      var position = await getLocationBackground();
      if (position != null) {
        userPosition = position;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.phoneNumber.toString())
            .update(
                {"position": GeoPoint(position.latitude,position.latitude)});
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Map Screen"),
      ),
      body: FutureBuilder<Position>(
        future: getLocation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          if (snapshot.error == "Enable Location Service") {
            return Center(
              child: Text("Location Service Disabled"),
            );
          }
          if (snapshot.error ==
              "Enable location permission for app from settings") {
            return Center(
              child: Text("Location Permission Disabled for the app"),
            );
          }
          userPosition = snapshot.data!;
          FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.phoneNumber!).update({"position":GeoPoint(userPosition.latitude,userPosition.longitude)});
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              List docs = snapshot.data!.docs;
              markers.clear();
              docs.forEach((element) {
                print(element["mobile"] + " " + FirebaseAuth.instance.currentUser!.phoneNumber);
                print(element["position"].latitude.toString() + " " + userPosition.latitude.toString());
                if (element["position"].latitude >= 26.183143 &&
                    element["position"].latitude <= 26.203567 &&
                    element["position"].longitude >= 91.686675 &&
                    element["position"].longitude <= 91.74583) {
                  markers.add(Marker(
                      markerId: MarkerId(element["mobile"]),
                      position: LatLng(element["position"].latitude,
                          element["position"].longitude),
                      icon: (element["mobile"]==FirebaseAuth.instance.currentUser!.phoneNumber && double.parse(element["position"].latitude.toStringAsFixed(4))==double.parse(userPosition.latitude.toStringAsFixed(4)) && double.parse(element["position"].longitude.toStringAsFixed(4))==double.parse(userPosition.longitude.toStringAsFixed(4))) ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue) : (element["covid_status"]==true ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed) : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)),
                  ),);
                }
              });
              return GoogleMap(
                onMapCreated: (controller){
                  _googleMapController=controller;
                  ifMapInitialized=true;
                },
                markers: markers,
                initialCameraPosition: CameraPosition(
                    target: LatLng(26.1878, 91.6916), zoom: 14.7),
              );
            },
          );
        },
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        if (ifMapInitialized == true) {
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(userPosition.latitude, userPosition.longitude),
                zoom: 14.7),
          ),);
        }
      },
      child: Icon(Icons.location_searching),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
