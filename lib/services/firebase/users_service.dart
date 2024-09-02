

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/contact/contact_dto.dart';

class UsersService {
  final FirebaseFirestore _firebaseService = FirebaseFirestore.instance;

  Future<List<ContactDto>> getUsersInDb() async {
   QuerySnapshot<Map<String, dynamic>> userList = await  _firebaseService.collection('users').get();
   List<ContactDto> users = userList.docs.map((doc) {
    return ContactDto.fromJson(doc.data());
   }).toList();

   return users;
  }
}