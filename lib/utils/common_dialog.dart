

import 'package:flutter/material.dart';

showProgress(BuildContext context){
  showDialog(context: context, builder: (context) => const Center(
    child: CircularProgressIndicator(
      color: Colors.black,
      backgroundColor: Colors.white,
    ),
  ));
}

hideProgress(BuildContext context){
  Navigator.pop(context);
}