
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Subir imagen a Firebase Storage
  Future<String?> uploadImage(File image) async {
    try {
      String fileName = basename(image.path);
      Reference ref = _storage.ref().child('uploads/$fileName');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error al subir la imagen: $e');
      return null;
    }
  }

  Future<String> uploadImageProfile(XFile file) async {
    String filePath =
        'uploads/${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    Reference ref = _storage.ref().child(filePath);
    await ref.putFile(File(file.path));
    String fileUrl = await ref.getDownloadURL();
    return fileUrl;
  }

  // Descargar imagen desde Firebase Storage
  Future<Image?> downloadImage(String imageUrl) async {
    try {
      final downloadUrl = await _storage.refFromURL(imageUrl).getDownloadURL();
      return Image.network(downloadUrl);
    } catch (e) {
      print('Error al descargar la imagen: $e');
      return null;
    }
  }

  // Obtener imagen desde la galería
  Future<File?> pickImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Error al seleccionar imagen: $e');
    }
    return null;
  }

  // Obtener imagen desde la cámara
  Future<File?> pickImageFromCamera() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print('Error al tomar foto: $e');
    }
    return null;
  }
}
