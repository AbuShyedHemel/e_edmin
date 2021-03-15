import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firestone = FirebaseFirestore.instance;

  void creatBrands(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _firestone.collection('brand').doc(brandId).set({'BrandName': name});
  }
}
