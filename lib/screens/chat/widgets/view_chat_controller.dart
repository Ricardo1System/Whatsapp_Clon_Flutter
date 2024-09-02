
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/theme/theme.dart';

class ViewChatController extends StatefulWidget {
  const ViewChatController({
    super.key,
  });

  @override
  State<ViewChatController> createState() => _ViewChatControllerState();
}

class _ViewChatControllerState extends State<ViewChatController> {

 TextEditingController messageController = TextEditingController();


 @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChange>(context).currenttheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color primary = appTheme.colorScheme.primary;
    Color secondary = appTheme.colorScheme.onPrimary;
    Color backgroundColor = appTheme.colorScheme.background;
    return Container(
      padding: const EdgeInsets.all(10.0),
      width:   double.infinity,
      height:  height * 0.1,
      // color: Colors.red,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              color: primary,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  offset: Offset(0.0, 3.0)
                )
              ]
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon:  Icon(Icons.tag_faces_sharp, color: secondary),
                  ),
                  SizedBox(
                    width: width * 0.5,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: secondary,
                      onChanged: (value) {
                        setState(() {
                          
                        });
                      },
                      controller:messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        
                      ),
                    ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                decoration:BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 3.0)
                    )
                  ],
                color: primary,
                shape: BoxShape.circle
                ),
                child: Center(
                  child: IconButton(onPressed: () {
                    messageController.clear();
                  }, icon: Icon( messageController.text == '' ?  Icons.mic : Icons.send, color: secondary)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}