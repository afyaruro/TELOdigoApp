import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';


class PeticionesImagenes {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;



  static Future<dynamic> cargarfoto(var foto, var idMesa) async {
    final fs.Reference storageReference =
        fs.FirebaseStorage.instance.ref().child("Negocios");

    fs.TaskSnapshot taskSnapshot =
        await storageReference.child(idMesa).putFile(foto);

    var url = await taskSnapshot.ref.getDownloadURL();

    return url.toString();
  }

 




}