import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arenapp/components/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arenapp/components/constants.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat_page';
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String messageText;
  late int number = 0;
  var txt = TextEditingController();

  ButtonStyle steadyRecorderStyle = ElevatedButton.styleFrom(shape: CircleBorder(),primary: Colors.green,elevation: 10);
  ButtonStyle recordingRecorderStyle = ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),primary: Colors.red,elevation: 10);
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  @override
  void initState() {
    super.initState();
    initRecorder();
    getCurrentUser();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Future initRecorder() async{
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(Duration(milliseconds: 500));
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print('Recorded audio: $audioFile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilderWidget(),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: txt,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      suffixIcon: AudioRecorder(),
                      hintText: 'Type your message.',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF297739)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Color(0xFF297739), width: 2.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    txt.text = '';
                    _firestore.collection('messages').add({
                      'text': messageText,
                      'sender': loggedInUser.email,
                      'date': DateTime.now().microsecondsSinceEpoch,
                    });
                  },
                  icon: const Icon(
                    Icons.near_me,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget StreamBuilderWidget(){
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('date').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          final messages = snapshot.data?.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages!) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            //final int messageDate = message.get('date');
            final dateHour = new DateTime.fromMicrosecondsSinceEpoch(message.get('date'))
                .hour;
            final dateMinute = new DateTime.fromMicrosecondsSinceEpoch(message.get('date'))
                .minute;
            if(messageSender == loggedInUser.email){
              number = 1;
            }else{
              number = 0;
            }
            final messageBubble = MessageBubble(
                text: messageText, sender: messageSender,number: number,dateHour: dateHour,dateMinute: dateMinute);
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              reverse: true,
              padding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 10),
              children: messageBubbles,
            ),
          );
        } else {
          return Center();
        }
      },
    );
  }
  Widget AudioRecorder(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: recorder.isRecording,
          child: StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context,snapshot){
                final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
                return Text('${duration.inSeconds}sn');
              }),
        ),
        ElevatedButton(
          style: recorder.isRecording ? recordingRecorderStyle : steadyRecorderStyle,
          onPressed: () async {
            if (recorder.isRecording) {
              await stop();
            } else {
              await record();
            }
            setState(() {});
          },
          child: Icon(
            recorder.isRecording ? Icons.stop : Icons.mic,
            size: 20,
          ),
        ),
      ],
    );
  }
}
