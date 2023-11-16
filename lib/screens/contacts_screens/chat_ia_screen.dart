import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatIAScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          Spacer(),
          Text('IA: Si y No')
        ]) ,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.call)),
          IconButton(onPressed: () {
            
          }, icon: Icon(Icons.more_vert)),
          
        ],
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatAIProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollcontroller,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];
                return message.fromWho == FromWho.me
                    ? MyMessageBubble(
                        message: message.text,
                      )
                    : HerMessageBubble(
                        message: message.text,
                        img: message.imageUrl!,
                      );
              },
            )),
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            )
          ],
        ),
      ),
    );
  }
}


class HerMessageBubble extends StatelessWidget {
  const HerMessageBubble({super.key, required this.message, required this.img});

  final String message;
  final String img;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              '$message',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _ImageBubble(img: img),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String img;

  const _ImageBubble({super.key, required this.img});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          '$img',
          width: size.width * 0.7,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child:
                  const Center(child: Text('Mi amor esta enviando un mesnaje')),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(child: Text('$error')),
            );
          },
        ));
  }
}

class MyMessageBubble extends StatelessWidget {
  const MyMessageBubble({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
            child: Text('$message', style: const TextStyle(color: Colors.white),),
          ),
        ),
        const SizedBox(height: 10,)
      ],
    );
  }
}

class MessageFieldBox extends StatelessWidget {
  const MessageFieldBox({super.key, required this.onValue});

  final ValueChanged<String> onValue; 

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final TextEditingController textController = TextEditingController();
    final focusNode=FocusNode();

   final outlineInputBorder= UnderlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(40)
   );

   final inputDecoration= InputDecoration(
    hintText: 'End your message with a "?"',
        filled: true,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        suffixIcon: IconButton(
          icon:const Icon(Icons.send_outlined),
          onPressed: () {
            final textValue=textController.value.text;
            textController.clear();
            onValue(textValue);
          },
          )
      );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      decoration: inputDecoration,
      controller: textController,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onValue(value);
      },
    );
  }
}

class ChatAIProvider extends ChangeNotifier {
  final ScrollController chatScrollcontroller = ScrollController();
  final GetYesNotAnswer getYesNotAnswer=GetYesNotAnswer();

  List<Message> messageList = [
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty)return;
    final msj = Message(fromWho: FromWho.me, text: text);
    messageList.add(msj);

    if (text.endsWith('?')) {
      await herReply();
    }
    notifyListeners();
    moveScrollToBotton();
  }

  Future<void> moveScrollToBotton()async {
    Future.delayed(const Duration(milliseconds: 300));
    chatScrollcontroller.animateTo(
      chatScrollcontroller.position.maxScrollExtent,
      duration: const Duration(milliseconds:300 ),
      curve: Curves.easeOut,
    );
  }

  Future<void> herReply ()async{
    try {
      final herMessage = await getYesNotAnswer.getAnswer();
    messageList.add(herMessage);
    moveScrollToBotton();
      notifyListeners();
    } catch (e) {
      messageList.add(Message(text: e.toString(), fromWho: FromWho.me));
    }
    
  }
}

class Message {

  final String text;
  final String? imageUrl;
  final FromWho fromWho;

  Message({required this.text, this.imageUrl, required this.fromWho});
}


enum FromWho{me,hers}



class GetYesNotAnswer {

  final _dio=Dio();

  Future<Message>getAnswer()async{
    final response= await _dio.get('https://yesno.wtf/api');
    final yesNoModel=YesNoModel.fromJson(response.data);
    // throw UnimplementedError();
    return yesNoModel.toMessageEntity();
  }
  
}


class YesNoModel {
  String answer;
  bool forced;
  String image;

  YesNoModel({
    required this.answer,
    required this.forced,
    required this.image,
  });

  factory YesNoModel.fromRawJson(String str) =>
      YesNoModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory YesNoModel.fromJson(Map<String, dynamic> json) => YesNoModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
      };

  Message toMessageEntity() => Message(
        text: answer == 'yes'? 'Si': 'No',
        fromWho: FromWho.hers,
        imageUrl: image,
      );
}