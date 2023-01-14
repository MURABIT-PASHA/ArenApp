import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../components/constants.dart';
import '../components/rounded_button.dart';

class SolutionForm extends StatefulWidget {
  const SolutionForm({Key? key}) : super(key: key);

  @override
  State<SolutionForm> createState() => _SolutionFormState();
}

class _SolutionFormState extends State<SolutionForm> {
  String _solution = "";
  String _itemName = "Solution";
  final _itemHint = "Type your solution name";
  final _imageSolutions = [
    'Pixelate Generator',
    'Icon Generator',
    'Image Generator',
    'Poster Generator',
    'Profile Image Generator'
  ];
  final _imageSolutionValues = [
    'pixGen',
    'icoGen',
    'imgGen',
    'posGen',
    'proGen'
  ];
  final _textSolutions = ['Conversation', 'Summarize Text', 'Write Article'];
  final _textSolutionValues = ['conText', 'sumText', 'wriText'];
  final _audioSolutions = ['Voice Generator'];
  final _audioSolutionValues = ['voiGen'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Solution"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width - 100,
                height: 50,
                child: TextField(
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: _itemHint,
                  ),
                  onChanged: (value) {
                    _itemName = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: CustomRadioButton(
                  customShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  elevation: 10,
                  absoluteZeroSpacing: true,
                  unSelectedColor: Colors.white38,
                  buttonLables: [
                    'Text',
                    'Image',
                    'Audio',
                  ],
                  buttonValues: [
                    "text",
                    "image",
                    "audio",
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle: TextStyle(fontSize: 16)),
                  radioButtonValue: (value) {
                    _solution = value.toString();
                    print(_solution);
                    setState(() {});
                  },
                  selectedColor: Colors.red,
                ),
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(12)),
                  child: _solution == ""?Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 300,
                    child: Text("Select what you need"),
                  ):CustomRadioButton(
                    horizontal: true,
                    elevation: 10,
                    absoluteZeroSpacing: false,

                    unSelectedColor: Colors.white38,
                    buttonLables: _solution == "text"
                        ? _textSolutions
                        : _solution == "image"
                        ? _imageSolutions
                        : _solution == "audio"
                        ? _audioSolutions
                        : [],
                    buttonValues: _solution == "text"
                        ? _textSolutionValues
                        : _solution == "image"
                        ? _imageSolutionValues
                        : _solution == "audio"
                        ? _audioSolutionValues
                        : [],
                    buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(fontSize: 16)),
                    radioButtonValue: (value) {
                      print(value);
                    },
                    selectedColor: Colors.red,
                  ),
                ),
              ),
              RoundedButton(
                  colour: Colors.black54,
                  buttonTitle: 'Create',
                  onPressed: () {
                    setState(() {
                    });
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
