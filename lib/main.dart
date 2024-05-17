import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/app/app.dart';
import 'package:telodigo/data/controllers/mapcontroller.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.clearPersistence();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: false);

  Get.put(UserController());
  Get.put(NegocioController());
  Get.put(MapController());
  
  runApp(const MyApp()); 
  //  runApp(CrearClienteScreen());
  
}
