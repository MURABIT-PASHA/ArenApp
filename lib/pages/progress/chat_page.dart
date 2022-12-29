import 'dart:async';
import 'dart:math';
import 'package:arenapp/data/model/conversation.dart';
import 'package:arenapp/data/model/open_ai.dart';
import 'package:flutter/material.dart';
import 'package:arenapp/components/message_bubble.dart';
import 'package:arenapp/components/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({Key? key, required this.title}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController txt = TextEditingController();

  //Speech variables starts here
  bool _hasSpeech = false;
  bool _logEvents = true;
  bool _onDevice = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  final SpeechToText speech = SpeechToText();
  //Speech variables ends here

  @override
  void initState() {
    initSpeechState();
    super.initState();
  }

  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: _logEvents,
      );
      if (hasSpeech) {
        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    final pauseFor = int.tryParse('3');
    final listenFor = int.tryParse('50');
    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: listenFor ?? 50),
      pauseFor: Duration(seconds: pauseFor ?? 3),
      partialResults: true,
      localeId: _currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
      onDevice: _onDevice,
    );
    setState(() {});
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords}';
      txt.text = lastWords;
      print(lastWords);
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(lastError)));
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });
  }


  void _logEvent(String eventDescription) {
    if (_logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  List<Conversation> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg_chat.png"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: txt,
                        onChanged: (value) {
                          if (txt.text!= ''){
                            value = txt.text;
                          }
                        },
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: "Type your message here",
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF297739)),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF297739), width: 2.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async{
                        if(txt.text!='') {
                          Conversation _conversation1 = Conversation(prompt: txt.text, number: 1, date: DateTime.now());
                          messages.add(_conversation1);
                          setState(() {
                          });
                          OpenAI _openAI = OpenAI( prompt: txt.text,);
                          var data = await _openAI.getResponse();
                          Conversation _conversation2 = Conversation(prompt: data['choices'][0]['text'], number: 0, date: DateTime.now());
                          messages.add(_conversation2);
                          setState(() {
                            txt.text = '';
                          });
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Message cannot be empty")));
                        }
                      },
                      icon: const Icon(
                        Icons.near_me,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 150,
                  child: ListView.builder(
                    controller: ScrollController(initialScrollOffset: 1),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<MessageBubble> messageBubbles = [];
                      for (var message in messages) {
                        final messageText = message.prompt;
                        final number = message.number;
                        final dateHour =
                            message.date.hour;
                        final dateMinute =
                            message.date.minute;
                        final messageBubble = MessageBubble(
                            prompt: messageText,
                            number: number,
                            dateHour: dateHour,
                            dateMinute: dateMinute);
                        messageBubbles.add(messageBubble);
                      }
                      return messageBubbles[index];
                    },),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SpeechRecognitionWidget(
                    lastWords: lastWords,
                    level: level,
                    hasSpeech: _hasSpeech,
                    isListening: speech.isListening,
                    startListening: startListening,
                    stopListening: stopListening,
                    cancelListening: cancelListening,
                    txt: txt,
                  )),
            ],
          ),
        ),
      ),
    );
  }

}

class SpeechRecognitionWidget extends StatelessWidget {
  const SpeechRecognitionWidget({
    Key? key,
    required this.lastWords,
    required this.level,
    required this.hasSpeech,
    required this.isListening,
    required this.startListening,
    required this.stopListening,
    required this.cancelListening,
    required this.txt,
  }) : super(key: key);

  final String lastWords;
  final double level;
  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;
  final TextEditingController txt;
  @override
  Widget build(BuildContext context) {
    //lastWords
    return Row(
      children: [
        Container(
          height: 60,
          width: (MediaQuery.of(context).size.width - 60) / 2,
          child: Lottie.asset("assets/jsons/waves.json", animate: isListening, fit: BoxFit.fill),
        ),
        GestureDetector(
          onTap: () {
            // Cancel
            //isListening ? cancelListening : null;
          },
          onLongPress: !hasSpeech || isListening ? null : startListening,
          onLongPressUp: isListening ? stopListening : null,
          child: Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .26,
                    spreadRadius: level * 1.5,
                    color: Colors.black.withOpacity(.05))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Icon(
              Icons.mic,
              color: Colors.green,
            ),
          ),
        ),
        Container(
            height: 60,
            width: (MediaQuery.of(context).size.width - 60) / 2,
            child:
                Lottie.asset("assets/jsons/waves.json", animate: isListening, fit: BoxFit.fill)),
      ],
    );
  }
}