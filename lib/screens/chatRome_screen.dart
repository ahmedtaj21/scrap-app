import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrap_app/component/crud.dart';
import 'package:scrap_app/constant/linkApi.dart';
import 'package:scrap_app/main.dart';

class chatRome extends StatefulWidget {
  final String senderId;
  final String receiverId;
  final String receiverName;
  const chatRome({
    super.key,
    required this.senderId,
    required this.receiverId,
    required this.receiverName,
    //required this.id2
  });

  @override
  State<chatRome> createState() => _chatRomeState();
}

class _chatRomeState extends State<chatRome> {
  String? masseageText;
  final firstor = FirebaseFirestore.instance;
  final messageTextControlr = TextEditingController();
  Curd _curd = Curd();

  addChatInfo() async {
    var respons = await _curd.postRequst(linkchate, {
      "Sender": widget.senderId,
      "Receiver": widget.receiverId,
      "SenderToken": sharedPref.getString("token") ?? "",
      "senderName": sharedPref.getString("username") ?? "",
      "receiverName": widget.receiverName
    });
    if (respons["exsist"] == "yes") {
      print(respons["exsist"]);
    } else {
      if (respons["status"] == "success") {
        print(respons["status"]);
      } else {
        print(respons["status"]);
      }
    }
  }

  addChatInfo2() async {
    var respons = await _curd.postRequst(linkchate, {

      "Sender":widget.senderId,
      "Receiver": widget.receiverId,
      "SenderToken": sharedPref.getString("token") ?? "",
      "senderName": sharedPref.getString("username") ?? "",
      "receiverName": widget.receiverName
    });
    if (respons["exsist"] == "yes") {
      print(respons["exsist"]);
    } else {
      if (respons["status"] == "success") {
        print(respons["status"]);
      } else {
        print(respons["status"]);
      }
    }
  }

  void masseagesStreams() async {
    await for (var snapshot in firstor
        .collection("chats")
        .doc(widget.senderId)
        .collection("messages")
        .snapshots()) {
      for (var message in snapshot.docs) {
        print(message);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firstor
                  .collection("chats")
                  .doc(widget.senderId
                      //  "16"
                      )
                  .collection(
                      //  sharedPref.getString("id") ?? ""
                      widget.receiverId
                      //"14"
                      )
                  .orderBy("time")
                  .snapshots(),
              builder: (context, snapshot) {
                List<messagLine> messageWidgets = [];
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                for (var message in messages) {
                  final messageText = message.get("text");
                  final messageSender = message.get("sender");
                  final messageWidget = messagLine(
                    sender: messageSender,
                    text: messageText,
                  );
                  messageWidgets.add(messageWidget);
                }

                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messageWidgets,
                  ),
                );
              }),
          Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.black, width: 2),
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextControlr,
                    onChanged: (Valu) {
                      masseageText = Valu;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        hintText: "اكتب رسالتك هنا ",
                        border: InputBorder.none),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      messageTextControlr.clear();
                      firstor
                          .collection("chats")
                          .doc(widget.senderId.toString())
                          .collection(
                              //sharedPref.getString("id") ?? ""
                              widget.receiverId.toString())
                          .add({
                        "text": masseageText,
                        "sender": sharedPref.getString("username") ?? "",
                        "time": FieldValue.serverTimestamp()
                      });
                    (widget.senderId == sharedPref.getString("id"))?
                      await addChatInfo()
                      :  await addChatInfo2();
                      //88888
                      // firstor
                      //     .collection("chats")
                      //     .doc(widget.id)
                      //     .coc llection(sharedPref.getString("username") ?? "")
                      //     .add({
                      //   "text": masseageText,
                      //   "sender": sharedPref.getString("username") ?? ""
                      // });
                      //     firstor.collection("chats")
                      //     .doc(sharedPref.getString("username") ?? "")
                      //     .collection(widget.id)
                      //     .add({
                      //   "text": masseageText,
                      //   "sender": sharedPref.getString("username") ?? ""
                      // });
                    },
                    child: Text(
                      "إرسال",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ))
              ],
            ),
          )
        ],
      )),
    );
  }
}

class messagLine extends StatefulWidget {
  final String? sender;
  final String? text;
  const messagLine({super.key, required this.sender, required this.text});

  @override
  State<messagLine> createState() => _messagLineState();
}

class _messagLineState extends State<messagLine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (sharedPref.getString("username") == widget.sender)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(widget.sender.toString(),
            style: TextStyle(fontSize: 12, color: Colors.black45)),
        Material(
          elevation: 5,
          borderRadius: (sharedPref.getString("username") == widget.sender)
              ? BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(
                    30,
                  ),
                  bottomRight: Radius.circular(30))
              : BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(
                    30,
                  ),
                  bottomRight: Radius.circular(30)),
          color: (sharedPref.getString("username") == widget.sender)
              ? Colors.black54
              : Color.fromARGB(255, 150, 145, 145),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              '${widget.text} ',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
