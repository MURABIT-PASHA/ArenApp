import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../progress/home_page.dart';
import './models/onboard_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardPage extends StatefulWidget {
  static const String id = 'onboardScreen';

  const OnboardPage({Key? key}) : super(key: key);
  @override
  _OnboardPage createState() => _OnboardPage();
}

class _OnboardPage extends State<OnboardPage> {
  DateTime timeBackPressed = DateTime.now();
  final controller = PageController();
  int isLastPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFF0E1937),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index;
              });
            },
            children: [
              OnboardModel(
                  urlImage: 'assets/jsons/page1.json',
                  title: 'Easy to Use',
                  subtitle:
                      'The app provides to direct chat. And there is no ads in it.'),
              OnboardModel(
                  urlImage: 'assets/jsons/page2.json',
                  title: 'Ask Anything',
                  subtitle:
                      'You can easily ask anything you want. Until your questions is not special.'),
              OnboardModel(
                  urlImage: 'assets/jsons/page3.json',
                  title: 'Let\'s Get Started',
                  subtitle:
                      'We happy to see you. Remember, we did that for a free. So, your feedback is precious to us.'),
            ],
          ),
        ),
        bottomSheet: isItLastPage(isLastPage),
      ),
    );
  }

  Widget isItLastPage(int index) {
    switch (index) {
      case 0:
        return PageBottomNavigator(controller: controller);
      case 1:
        return PageBottomNavigator(controller: controller);
      case 2:
        return TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            backgroundColor: Color(0xFF0E1937),
            minimumSize: const Size.fromHeight(80.0),
          ),
          child: const Text(
            'Tackle In',
            style: TextStyle(
                fontSize: 45,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool('showHome', true);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>HomePage()),(route) => false);
          },
        );
      default:
        return PageBottomNavigator(
          controller: controller,
        );
    }
  }
}

class PageBottomNavigator extends StatelessWidget {
  const PageBottomNavigator({Key? key, required this.controller})
      : super(key: key);

  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF0E1937),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: const Text(
              'SKIP',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              controller.jumpToPage(2);
            },
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                radius: 8.0,
                spacing: 12.0,
                dotColor: Colors.black26,
                activeDotColor: Colors.white,
              ),
              onDotClicked: (index) {
                controller.animateToPage(index,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeInOut);
              },
            ),
          ),
          TextButton(
            child: const Text(
              'NEXT',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              controller.nextPage(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.easeInOut);
            },
          ),
        ],
      ),
    );
  }
}
