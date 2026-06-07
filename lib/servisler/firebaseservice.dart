import 'package:cloud_firestore/cloud_firestore.dart';
import '../modeller/icerikmodeli.dart';

class FirebaseService {
  
  final CollectionReference _koleksiyon = FirebaseFirestore.instance.collection('icerikler');

 
  Future<List<IcerikModeli>> getIcerikler() async {
    final snapshot = await _koleksiyon.get();
    
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
    
      data['id'] = doc.id; 
      return IcerikModeli.fromJson(data);
    }).toList();
  }

  Future<void> ekleIcerik(IcerikModeli model) async {
    await _koleksiyon.add(model.toJson());
  }

  Future<void> silIcerik(String id) async {
    await _koleksiyon.doc(id).delete();
  }
}