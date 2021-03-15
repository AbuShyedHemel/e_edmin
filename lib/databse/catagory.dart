import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CatagoryService {
  FirebaseFirestore _firestone = FirebaseFirestore.instance;

  void creatCatagory(String name) {
    var id = Uuid();
    String catagoryId = id.v1();
    _firestone.collection('catagories').doc(catagoryId).set({'catagoryName': name});
  }
}
