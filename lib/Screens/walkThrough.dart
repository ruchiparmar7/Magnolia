import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:magnolia/Constant/constants.dart';
import 'package:magnolia/Custom/MyCustomButton.dart';
import 'package:magnolia/NavigationDrawer/bottomNavigation.dart';
import 'package:magnolia/Registration/signin.dart';
import 'package:magnolia/Screens/localAuth.dart';

class WalkThrough extends StatefulWidget {
  static String route = "WalkThrough";
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();
  int currentIndexPage = 0;
  double countdots = 0;

  AnimationController? _controller;
  Animation<double>? _animation;

  var titles = [
    "All important tips",
    "Meditation is useful for health",
    "Jogging is good for health"
  ];

  var subTitles = [
    "Lorem Ispum is simply dummy text of the printing and typesetting industry.This is simply text",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  "
  ];

  @override
  void initState() {
    currentIndexPage = 0;
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.linear);
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              WalkThroughPageView(imgPath: bookLogo),
              WalkThroughPageView(imgPath: bookLogo),
              WalkThroughPageView(imgPath: bookLogo)
            ],
            onPageChanged: (value) {
              setState(() {
                currentIndexPage = value;
              });
            },
          ),
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            height: 50,
            top: MediaQuery.of(context).size.height * 0.58,
            child: Align(
              alignment: Alignment.center,
              child: new DotsIndicator(
                dotsCount: 3,
                position: currentIndexPage.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Color(0XFF5959fc),
                  // activeSize: Size.circle(10.0),
                  activeShape: CircleBorder(),
                ),
              ),
            )),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  titles[currentIndexPage],
                  style: TextStyle(fontSize: 18, color: Color(0XFF747474)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
                new ScaleTransition(
                  scale: _animation!,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MyCustomButton(
                        textContent: "Get Started",
                        onPressed: () {
                          if (currentIndexPage != 2) {
                            //next pageView

                            currentIndexPage = currentIndexPage + 1;
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 2200),
                                curve: Curves.easeOutCirc);
                          } else {
                            Navigator.of(context).pushNamed(SignIn.route);
                            /////Navigator.of(context).pushNamed(LocalAuth.route);
                            // Navigator.of(context)
                            //     .pushNamed(CustomBottomNavigationBar.route);
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  MaterialColor materialColor(colorHax) {
    return MaterialColor(colorHax, color);
  }

  @override
  void dispose() {
    // controller.dispose();
    _controller!.dispose();
    super.dispose();
  }
}

class WalkThroughPageView extends StatelessWidget {
  final String? imgPath;

  WalkThroughPageView({Key? key, required this.imgPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SizedBox(
          child: Stack(
        children: <Widget>[
          Image.asset(walkthroughBg,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 1.7)),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height / 1.7),
              alignment: Alignment.center,
              child: Image.asset(
                imgPath!,
                width: 300,
                height: (MediaQuery.of(context).size.height / 2.5),
              ),
            ),
          )
        ],
      )),
    );
  }
}
