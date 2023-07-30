import 'package:flutter/material.dart';

class StateScreen extends StatelessWidget {
   
  const StateScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: const Icon(Icons.camera_alt_rounded),
      ),
      body: Center(
         child: Text('StateScreen'),
      ),
    );
  }
}