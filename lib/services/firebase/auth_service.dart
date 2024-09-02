
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //Registrar usuario en firebase
    
  //Escuchar los cambios de la authenticación
  Stream<bool> get isAuthenticated {
    return FirebaseAuth.instance.authStateChanges().map((User? user) => user != null);
  }
}