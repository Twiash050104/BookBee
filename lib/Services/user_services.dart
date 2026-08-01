import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getCurrentUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await _firestore.collection('users').doc(uid).get();

    return UserModel.fromMap(doc.id, doc.data()!);
  }
}
