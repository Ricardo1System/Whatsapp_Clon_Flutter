import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<SetCode>((event, emit) => _setCode(event, emit));
    on<SendCode>((event, emit) => _sendCode(event, emit));
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String verificationIdModel='';
  String numberModel='';

  Future<void> _sendCode(SendCode event, Emitter<AuthState> emit) async {
    // emit(SendCodeLoading());
    

    try {
      String number = event.number.replaceAll("(", "").replaceAll(")", "");
      await auth.verifyPhoneNumber(
        phoneNumber: '+52 $number',
        codeSent: (String verificationId, int? resendToken) async {
          verificationIdModel=verificationId;
          numberModel=number;
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
           
        },
        verificationFailed: (FirebaseAuthException error) {
       
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      // emit(SendCodeLoaded());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
  
  Future<void> _setCode (SetCode event, Emitter<AuthState> emit) async {
      FirebaseAuth auth = FirebaseAuth.instance;
      emit(SendCodeLoading());
  try {
    // Crea una PhoneAuthCredential con el código ingresado por el usuario
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdModel,
      smsCode: event.smsCode,
    );

    // Autentica al usuario
    UserCredential userCredencial= await auth.signInWithCredential(credential);
   if (userCredencial!=null) {
     _createUser(userCredencial);
      emit(SendCodeLoaded());
   }
  
    // auth.cre
  } catch (e) {
    // Maneja cualquier error durante la autenticación
  }
  }
  
  void _createUser(UserCredential userCredencial) async {
    // El usuario está autenticado, puedes realizar acciones aquí
    var db = FirebaseFirestore.instance;
    // Create a new user with a first and last name

    var any = await db.collection("/users").doc(userCredencial.user!.uid).get();
    if (!any.exists) {
      final user = <String, dynamic>{
        "Name"         : "UserName",
        "Number"       : numberModel,
        "Info"         : "Empty",
        "ImageProfile" : "",
      };

    // Add a new document with a generated ID
      db
          .collection("users")
          .doc(userCredencial.user!.uid)
          .set(user)
          .then((_) =>
              print('Document added with ID: ${userCredencial.user!.uid}'))
          .catchError((error) => print('Error adding document: $error'));
    }
  }
  




 






}
