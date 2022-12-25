import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class Microphone extends StatefulWidget {
  const Microphone({Key? key}) : super(key: key);

  @override
  State<Microphone> createState() => _MicrophoneState();
}

class _MicrophoneState extends State<Microphone> {
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
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
    return AudioRecorder();
  }
  Widget AudioRecorder(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<RecordingDisposition>(
            stream: recorder.onProgress,
            builder: (context,snapshot){
              final duration = snapshot.hasData ? snapshot.data!.duration : Duration.zero;
              return Text('${duration.inSeconds}sn');
            }),
        SizedBox(height: 32,),
        ElevatedButton(
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
            size: 80,
          ),
        ),
      ],
    );
  }
}
