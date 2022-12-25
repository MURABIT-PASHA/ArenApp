import 'dart:math';
import 'dart:io';
import 'package:arenapp/pages/progress/square.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String id = 'settings_screen';
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final double coverHeight = 280; //Arkaplan resmi yüksekliği
  final double profileHeight = 140; // Profil resmi çapı
  final double editIconRadius = 20; // Düzenleme iconu yarıçapı
  final _firestore = FirebaseStorage.instance;
  late Future<ListResult> futureFiles;
  String email = '';
  @override
  void initState() {
    getUserMail();
    futureFiles = _firestore.ref('/profiles').list();
    print(futureFiles);
    super.initState();
  }
  Future<String> getUserMail() async {
    final prefs = await SharedPreferences.getInstance();
    final tempMail = prefs.getString('userMailAddress') ?? 'defaultUser';
    email = tempMail;
    return email;
  }
  Future<File> getUserProfileImage(Reference ref) async{
    final mail = await getUserMail();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    await ref.writeToFile(file);
    return file;
  }
  @override
  Widget build(BuildContext context) {
    final profileTop = coverHeight - profileHeight / 2;
    final editTop = profileHeight / 4 +
        profileHeight / 4 * pow(3, 1 / 2) +
        editIconRadius / 2;
    final editLeft = profileHeight / 4 + profileHeight / 4 + editIconRadius;
    return Scaffold(
        body: ListView(
      children: [
        // Arkaplan ve profil resmi
        Container(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              //Arkaplan
              Column(
                children: [
                  Container(
                      color: Colors.grey,
                      child: Image.asset('assets/images/foreground.png',
                          width: double.infinity,
                          height: coverHeight,
                          fit: BoxFit.cover)),
                  Container(
                    height: profileHeight / 2,
                  )
                ],
              ),
              //Profil ve düzenleme ikonu
              Positioned(
                top: profileTop,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    FutureBuilder<ListResult>(
                      future: futureFiles,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final files = snapshot.data!.items;
                          final index = files.indexWhere((element) =>
                          element.name == getUserMail());
                          final file = files[index];
                          final realFile = getUserProfileImage(file);
                          return Text("ddd");
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Resim yüklenirken hata oluştu'),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Positioned(
                      top: editTop,
                      left: editLeft,
                      height: 40,
                      width: 100,
                      child: BuildEditImageIcon(FontAwesomeIcons.pen),
                    ),
                  ],
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(
            bottom: profileHeight / 8,
          ),
        ),
        //Yazı ve Sosyal Medya iconları
        Column(
          children: [
            const SizedBox(height: 10),
            //Giriş yapan kişinin isim bilgisi yazdırılacak
            Text(
              "Name Surname",
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Dongle-Regular"),
            ),
            const SizedBox(height: 8),
            // Giriş yapan kişinin görev bilgisi yazdırılacak
            Text(
              'Job Title',
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            const SizedBox(height: 5),
            Divider(), //Ayraç
            const SizedBox(height: 5),
            //Sosyal medya ikonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildSocialMediaIcon(FontAwesomeIcons.linkedin, "http"),
                const SizedBox(
                  width: 12,
                ),
                BuildSocialMediaIcon(FontAwesomeIcons.github, "http"),
                const SizedBox(
                  width: 12,
                ),
                BuildSocialMediaIcon(FontAwesomeIcons.medium, "http"),
              ],
            )
          ],
        ),
      ],
    ));
  }

  Widget BuildSocialMediaIcon(IconData icon, String url) {
    return CircleAvatar(
      radius: 25.0,
      child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          //gelen url'ye göre yönlendirme
          child: InkWell(
              onTap: () {
                //TODO: implement social media accounts
              },
              child: Center(
                child: Icon(icon, size: 32),
              ))),
    );
  }


  Widget BuildEditImageIcon(IconData icon) {
    return ExpandableNotifier(
      controller: ExpandableController(),
      // <-- Provides ExpandableController to its children
      child: Row(
        children: [
          Expandable(
            // <-- Driven by ExpandableController from ExpandableNotifier
            collapsed: ExpandableButton(
              theme: ExpandableThemeData(
                useInkWell: true,
                alignment: Alignment.center
              ),
              // <-- Expands when tapped on the cover photo
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade800,
                ),
                child: Icon(
                  icon,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            expanded: ExpandableButton(
              theme: ExpandableThemeData(
                alignment: Alignment.center,
                bodyAlignment: ExpandablePanelBodyAlignment.center
              ),
              // <-- Collapses when tapped on
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade800,
                ),
                child: ListView(

                  scrollDirection: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        setState((){
                          Navigator.pushNamed(context, SquarePage.fromGallery);
                        });

                      },
                      child: Icon(
                        Icons.perm_media,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        setState((){
                          Navigator.pushNamed(context, SquarePage.fromCamera);
                        });
                      },
                      child: Icon(
                        FontAwesomeIcons.camera,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
