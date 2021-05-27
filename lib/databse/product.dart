import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'products';

  void uploadProduct(
      {String productName,
      String brand,
      int quantity,
      String category,
      List sizes,
      List images,
      double price}) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(ref).doc(productId).set({
      'name': productName,
      'category': category,
      'brand': brand,
      'quantity': quantity,
      'price': price,
      'id': productId,
      'imageurl': images
    });
  }
}
