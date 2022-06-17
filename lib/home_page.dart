import 'dart:math' as math;

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piano_tiles/constants/strings.dart';
import 'package:piano_tiles/global/global_file.dart';
import 'package:piano_tiles/screens/Youtube_screen.dart';
import 'package:piano_tiles/screens/game_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int? highScore0;
  int? highScore1;
  int? highScore2;
  int? highScore3;
  int? highScore4;
  int? highScore5;
  int? highScore6;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2))
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    checkFirstSeen();
    // getData();
    setState(() {});
  }

  // getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     highScore = prefs.getInt("highScore")!.toInt();
  //   });
  // }

  Future<void> checkFirstSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    highScore0 = prefs.getInt('highScore0') ?? 0;
    highScore1 = prefs.getInt('highScore1') ?? 0;
    highScore2 = prefs.getInt('highScore2') ?? 0;
    highScore3 = prefs.getInt('highScore3') ?? 0;
    highScore4 = prefs.getInt('highScore4') ?? 0;
    highScore5 = prefs.getInt('highScore5') ?? 0;
    highScore6 = prefs.getInt('highScore6') ?? 0;
  }

  int? screen_high_score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/background.jpg',
              ),
              fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.07),
              // child: Image.asset(
              //   "assets/disk2.gif",
              //   width: 200,
              // ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                        child: child,
                      );
                    },
                    // child: FlutterLogo(size: 200),
                    child: Image.asset(
                      "assets/cdpng2.png",
                      width: 300,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 320,
                    child: Transform(
                      child: Image.asset(
                        "assets/stopper2.png",
                        width: 100,
                      ),
                      transform: new Matrix4.identity()
                        ..rotateZ(180 * 3.1415927 / 180),
                    ),
                  ),
                ],
              ),
              alignment: Alignment.topCenter,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    mainBodyLightColor,
                    mainBodyDarkColor,
                  ],
                  stops: [0.0, 1.0],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: BorderedText(
                  strokeWidth: 3.0,
                  strokeColor: strokeColor,
                  child: Text('NOW UNITED',
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 40,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          color: homeBannerTextColor,
                        ),
                      )),
                ),
                // Text(
                //   "NOW UNITED",
                //   style: TextStyle(
                //       color: Colors.pinkAccent,
                //       fontSize: 30,
                //       fontWeight: FontWeight.w900,),
                // ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    PianoLevel(
                      text: "Shape Of You",
                      musicFile: "assets/shape_of_you.wav",
                      index: 0,
                      // highScore: highScore != 0 ? highScore.toString() : "0",
                      // highScore: highScoreList0 == null
                      //     ? ""
                      //     : highScoreList0[highScoreList0.length - 1].toString(),
                      highScore: sharedPreferences!.getInt("highScore0") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore0"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubeVideoPage(
                                    videoUrl:
                                        "https://www.youtube.com/watch?v=JGwWNGJdvx8")));
                      },
                    ),
                    PianoLevel(
                      text: "Naruto Main Theme",
                      musicFile: "assets/naruto.wav",
                      index: 1,
                      // highScore: highScore != 0 ? highScore.toString() : "0",
                      highScore: sharedPreferences!.getInt("highScore1") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore1"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubeVideoPage(
                                    videoUrl: "https://youtu.be/HQ0kEKKRWzk")));
                      },
                    ),
                    PianoLevel(
                      text: "Naruto S and S",
                      musicFile: "assets/naruto_s_and_s.wav",
                      index: 2,
                      highScore: sharedPreferences!.getInt("highScore2") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore2"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubeVideoPage(
                                    videoUrl:
                                        "https://www.youtube.com/watch?v=Kk60F8a7-Jw")));
                      },
                    ),
                    PianoLevel(
                      text: "Unravel",
                      musicFile: "assets/unravel.wav",
                      index: 3,
                      // highScore: highScoreList3 == null
                      //     ? "0"
                      //     : highScoreList3[highScoreList3.length - 1].toString(),
                      highScore: sharedPreferences!.getInt("highScore3") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore3"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YoutubeVideoPage(
                                videoUrl: "https://youtu.be/xFMPBPOy9SI"),
                          ),
                        );
                      },
                    ),
                    PianoLevel(
                      text: "Naruto Alone",
                      musicFile: "assets/naruto_alone.wav",
                      index: 4,
                      // highScore: highScoreList4 == null
                      //     ? "0"
                      //     : highScoreList4[highScoreList4.length - 1].toString(),
                      highScore: sharedPreferences!.getInt("highScore4") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore4"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YoutubeVideoPage(
                                videoUrl: "https://youtu.be/xJFy1Lv_AhQ"),
                          ),
                        );
                      },
                    ),
                    PianoLevel(
                      text: "Samidare",
                      musicFile: "assets/samidare.wav",
                      index: 5,
                      // highScore: highScoreList5 == null
                      //     ? "0"
                      //     : highScoreList5[highScoreList5.length - 1].toString(),
                      highScore: sharedPreferences!.getInt("highScore5") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore5"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubeVideoPage(
                                    videoUrl:
                                        "https://www.youtube.com/watch?v=OEZdKA9nffo&ab_channel=ksolis")));
                      },
                    ),
                    PianoLevel(
                      text: "Naruto Despair",
                      musicFile: "assets/naruto_despair.wav",
                      index: 6,
                      // highScore: highScoreList6 == null
                      //     ? "0"
                      //     : highScoreList6[highScoreList6.length - 1].toString(),
                      highScore: sharedPreferences!.getInt("highScore6") != null
                          ? (screen_high_score =
                                  sharedPreferences!.getInt("highScore6"))
                              .toString()
                          : "0",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubeVideoPage(
                                    videoUrl: "https://youtu.be/IkbQ71K3n1M")));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class PianoLevel extends StatelessWidget {
  final String musicFile;
  final String text;
  final Function onTap;
  final String highScore;
  final int index;
  const PianoLevel({
    Key? key,
    required this.text,
    required this.musicFile,
    required this.onTap,
    required this.highScore,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(
              title: text,
              musicfile: musicFile,
              index: index,
              highScore: highScore,
            ),
          ),
        );
      },
      contentPadding: EdgeInsets.all(7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      tileColor: borderColor,
      // trailing: IconButton(
      //   onPressed: () {},
      //   icon: Image.asset("assets/play.png"),
      // ),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 0.5,
          ),
          gradient: LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white70,
              Colors.purpleAccent.withOpacity(0.02),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage("assets/music.png"),
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      InkWell(
                        onTap: () {
                          onTap();
                        },
                        child: Image(
                          alignment: Alignment.centerRight,
                          image: AssetImage("assets/play.png"),
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    highScore,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
