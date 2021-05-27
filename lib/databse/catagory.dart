import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CatagoryService {
  FirebaseFirestore _firestone = FirebaseFirestore.instance;
  String ref = 'catagories';

  void creatCatagory(String name) {
    var id = Uuid();
    String catagoryId = id.v1();
    _firestone.collection(ref).doc(catagoryId).set({'category': name});
  }

  Future<List<DocumentSnapshot>> getCatagory() =>
      _firestone.collection(ref).get().then((snaps) {
        return snaps.docs;
      });

  Future<List<DocumentSnapshot>> getSuggestions(String suggestation) => 
  _firestone
          .collection(ref)
          .where("category", isEqualTo: suggestation)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
