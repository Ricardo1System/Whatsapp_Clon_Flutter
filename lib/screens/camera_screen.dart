import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key,  this.typeCamera=0,  this.hideToolBar=false,  this.resolution=ResolutionPreset.medium});

  final int typeCamera;
  final bool hideToolBar;
  final ResolutionPreset resolution;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription>? cameras;
  CameraController? controller;
  XFile? image;

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  loadCamera() async{
    cameras= await availableCameras();
    if(cameras != null){
      controller=CameraController(cameras![widget.typeCamera], widget.resolution,enableAudio: false);

      controller!.initialize().then((_){
        if(!mounted){
          return;
        }
        setState(() {});
      }).catchError((Object e){
        if(e is CameraException){
          switch (e.code){
            case'CameraAccessDenied':
            break;
            default:
            break;
          }
        }
      });
    }else{
      print('Cámara no encontrada');
    }
  }

  @override
  Widget build(BuildContext context) {
    final shortestSide= MediaQuery.of(context).size.shortestSide;
    final isTablet = shortestSide >=550;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              image == null
                  ? isTablet
                      ? Expanded(
                          child: Container(
                              color: Colors.black,
                              //height: MediaQuery.of(context).size.height * 0.5,
                              child: controller == null
                                  ? const Center(
                                      child: Text(
                                        "Cargando Cámara...",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : !controller!.value.isInitialized
                                      ? const Center(
                                          child: CircularProgressIndicator(backgroundColor: Colors.white),
                                        )
                                      : CameraPreview(controller!)),
                        )
                      : Container(
                          color: Colors.black,
                          child: controller == null
                              ? const Center(
                                  child: Text(
                                    "Cargando Cámara...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : !controller!.value.isInitialized
                                  ? const Center(
                                      child: CircularProgressIndicator(backgroundColor: Colors.white),
                                    )
                                  : CameraPreview(controller!))
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: FileImage(File(image!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                    ),
              Expanded(
                child: Container(
                  color: const Color.fromARGB(220, 0, 0, 0),
                  child: Column(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                          flex: widget.hideToolBar ? 0 : 8,
                          child: image == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        widget.hideToolBar
                                            ? Container(
                                                height: 2.w,
                                              )
                                            : const SizedBox(),
                                        ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              if (controller != null) {
                                                //check if controller is not null
                                                if (controller!.value.isInitialized) {
                                                  //check if controller is initialized
                                                  image = await controller!.takePicture(); //capture image
                                                  setState(() {});
                                                }
                                              }
                                            } catch (e) {}
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            // shape: RoundedRectangleBorder(
                                            //   borderRadius: BorderRadius.circular(20.0),
                                            // ),
                                            padding: const EdgeInsets.all(10),
                                          ),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: MediaQuery.of(context).size.width * 0.1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.008,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    const Spacer(flex: 1),
                                    Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.06,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              image = null;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Text('Otra foto'),
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 2),
                                    Expanded(
                                      flex: 4,
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.06,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context, image);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.white,
                                          ),
                                          child: const Text('Guardar foto'),
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 1),
                                  ],
                                )),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
          widget.hideToolBar
              ? const SizedBox()
              : Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.16,
                  child: AppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    centerTitle: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
        ],
      ),
    );
  }
}