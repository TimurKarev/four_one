import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseServiceProvider =
    Provider<FirebaseService>((ref) => FirebaseService());

class FirebaseService {
  Future<void> saveDocumentWithAutoId(
      {required String collectionPath,
      required Map<String, dynamic> doc}) async {
    final reference = FirebaseFirestore.instance.collection(collectionPath);
    await reference.add(doc);
  }

  Stream<QuerySnapshot> collectionStream({required String path}) {
    Stream<QuerySnapshot> snapshot =
        FirebaseFirestore.instance.collection(path).snapshots();
    return snapshot;
  }
}
