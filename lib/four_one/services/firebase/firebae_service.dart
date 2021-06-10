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

  Future<bool> saveDocument(String path, Map<String, dynamic> data) {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference.set(data).then((value) => true).catchError((error) {
      print(error.toString());
      return false;
    });
  }

  Future<bool> updateDocument(String path, Map<String, dynamic> data) {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference.update(data).then((value) => true).catchError((error) {
      print(error.toString());
      return false;
    });
  }

  Future<Map<String, dynamic>> getDocument(String path) async {
    final reference = FirebaseFirestore.instance.doc(path);
    return await reference.get().then((value) {
      return value.data() as Map<String, dynamic>;
    });
  }

  Future<Map<String, dynamic>> getOrCreateDocument(
      String path, Map<String, dynamic> data) async {
    final reference = FirebaseFirestore.instance.doc(path);
    return await reference.get().then((value) {
      if (value.exists) {
        return value.data() as Map<String, dynamic>;
      } else {
        return reference.set(data).then((value) => data);
      }
    });
  }
}
