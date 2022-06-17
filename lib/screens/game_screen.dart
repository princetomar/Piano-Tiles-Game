import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piano_tiles/constants/strings.dart';
import 'package:piano_tiles/global/global_file.dart';
import 'package:piano_tiles/home_page.dart';
import 'package:piano_tiles/line.dart';
import 'package:piano_tiles/line_divider.dart';
import 'package:piano_tiles/note.dart';
import 'package:piano_tiles/song_provider.dart';

class GameScreen extends StatefulWidget {
  final String title;
  final String musicfile;
  final int index;
  final String highScore;
  const GameScreen({
    Key? key,
    required this.title,
    required this.musicfile,
    required this.index,
    required this.highScore,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  // AudioCache player = AudioCache();
  //
  // AudioPlayer audioPlayer = AudioPlayer();
  // assets audio player
  final assetsAudioPlayer = AssetsAudioPlayer();
  List<Note> notes = initNotes();
  late AnimationController animationController;
  int currentNoteIndex = 0;
  int points = 0;
  int? highscore;

  bool hasStarted = false;
  bool isPlaying = true;
  // to play music

  @override
  void initState() {
    // setState(() {});
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        if (notes[currentNoteIndex].state != NoteState.tapped) {
          //game over
          setState(() {
            isPlaying = false;
            notes[currentNoteIndex].state = NoteState.missed;
            // _stopFile();
          });

          animationController.reverse().then((_) {
            setState(() {
              _stopFile();
              // audioPlayer.stop();
            });
          }).then((value) => _showFinishDialog());
        } else if (currentNoteIndex == notes.length - 5) {
          //song finished

          _stopFile();
          _showFinishDialog();
        } else {
          setState(() => ++currentNoteIndex);
          animationController.forward(from: 0);
        }
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    assetsAudioPlayer.dispose();
    // audioPlayer.dispose();
    super.dispose();
  }

  void setHighScore() async {
    setState(() {
      if (points >
          (sharedPreferences!.getInt("highScore" + widget.index.toString()) ??
              0)) {
        setState(() {
          highScoreList1.add(points);
        });
        sharedPreferences!
            .setInt("highScore" + widget.index.toString(), points);
      }
    });
  }

  // Previous function to store highScore using SharedPreferences
  // void setHighScoreUsingArray() async {
  //   // sharedPreferences = SharedPreferences.getInstance() as SharedPreferences?;
  //   if (widget.index == 0) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore0") ?? 0)) {
  //         setState(() {
  //           highScoreList0.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore0", points);
  //       }
  //     });
  //     // sharedPreferences!
  //     //     .setInt("highScore0", highScoreList0[highScoreList0.length - 1]);
  //
  //   } else if (widget.index == 1) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore1") ?? 0)) {
  //         setState(() {
  //           highScoreList1.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore1", points);
  //       }
  //     });
  //   } else if (widget.index == 2) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore2") ?? 0)) {
  //         setState(() {
  //           highScoreList2.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore2", points);
  //       }
  //     });
  //   } else if (widget.index == 3) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore3") ?? 0)) {
  //         setState(() {
  //           highScoreList3.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore3", points);
  //       }
  //     });
  //   } else if (widget.index == 4) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore4") ?? 0)) {
  //         setState(() {
  //           highScoreList4.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore4", points);
  //       }
  //     });
  //   } else if (widget.index == 5) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore5") ?? 0)) {
  //         setState(() {
  //           highScoreList5.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore5", points);
  //       }
  //     });
  //   } else if (widget.index == 6) {
  //     setState(() {
  //       if (points > (sharedPreferences!.getInt("highScore6") ?? 0)) {
  //         setState(() {
  //           highScoreList6.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore6", points);
  //       }
  //     });
  //   } else {
  //     setState(() {
  //       if (points > highScoreList6[highScoreList6.length - 1]) {
  //         setState(() {
  //           highScoreList6.add(points);
  //         });
  //         sharedPreferences!.setInt("highScore6", points);
  //       }
  //     });
  //   }
  // }

  // function to get the current high score of the current screen
  int get_HighScore_of_CurrentScree() {
    return sharedPreferences!.getInt("highScore" + widget.index.toString()) ??
        0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gameBodyColor,
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: "FredokaOne",
            fontSize: 22,
          ),
        ),
        actions: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  "High Score",
                  style: TextStyle(
                    fontFamily: "FredokaOne",
                    fontSize: 14,
                    color: gameHighScoreTextColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  // get_HighScore_of_CurrentScree(),
                  (get_HighScore_of_CurrentScree() == null ||
                          get_HighScore_of_CurrentScree() == 0)
                      ? "0"
                      : get_HighScore_of_CurrentScree().toString(),
                  // highscore.toString(),
                  // "10",
                  style: TextStyle(
                    fontFamily: "FredokaOne",
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/background.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              _drawLine(0),
              LineDivider(),
              _drawLine(1),
              LineDivider(),
              _drawLine(2),
              LineDivider(),
              _drawLine(3),
            ],
          ),
          _drawPoints(),
        ],
      ),
    );
  }

  void _restart() {
    setState(() {
      hasStarted = false;
      isPlaying = true;
      notes = initNotes();
      points = 0;
      currentNoteIndex = 0;
    });

    animationController.reset();
    // audioPlayer.state = PlayerState.STOPPED;
    // audioPlayer.stop();
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
          title: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                'assets/background.jpg',
                // height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.15),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        // padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade100,
                              Colors.blue.shade600,
                            ],
                            stops: [0.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: BorderedText(
                            strokeWidth: 3.0,
                            strokeColor: Colors.black,
                            child: Text(
                              'GAME OVER',
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationColor: Colors.red,
                                  fontSize: 40,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
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
                    ],
                  ),
                ),
              ),
              Text(
                'Score: $points',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: IconButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.pop(context);
                            // setHighScoreUsingArray();
                            setHighScore();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          icon: Image.asset(
                            "assets/home.png",
                            height: 100,
                          ),
                        ),
                      ),
                      Center(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.pinkAccent,
                          onPressed: () async {
                            setState(() {});
                            // setHighScoreUsingArray();
                            setHighScore();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "RESTART",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: IconButton(
                          onPressed: () {
                            setState(() {});
                            // To set the highScore
                            //
                            //
                            // setHighScoreUsingArray();
                            setHighScore();
                            //
                            // setHighScore();
                            Navigator.pop(context);

                            _restart();
                          },
                          icon: Image.asset(
                            "assets/retry1.png",
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) => _restart());
  }

  void _onTap(Note note) {
    bool areAllPreviousTapped = notes
        .sublist(0, note.orderNumber)
        .every((n) => n.state == NoteState.tapped);
    print(areAllPreviousTapped);
    if (areAllPreviousTapped) {
      if (!hasStarted) {
        setState(() => hasStarted = true);
        animationController.forward();
      }
      //_playNote(note);
      // currentNoteIndex == 0 ? _playNote(widget.musicfile) : null;
      currentNoteIndex <= 0 ? _playFile(widget.musicfile) : null;

      setState(() {
        note.state = NoteState.tapped;
        ++points;
      });
    }
  }

  _drawLine(int lineNumber) {
    return Expanded(
      child: Line(
        lineNumber: lineNumber,
        currentNotes: notes.sublist(currentNoteIndex, currentNoteIndex + 5),
        onTileTap: _onTap,
        animation: animationController,
      ),
    );
  }

  _drawPoints() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Text(
          "$points",
          style: TextStyle(
            color: Colors.cyan.shade600,
            fontSize: 70,
            fontFamily: 'FredokaOne',
          ),
        ),
      ),
    );
  }

  void _playFile(String music) async {
    try {
      assetsAudioPlayer.open(
        Audio("$music"),
        showNotification: true,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void _stopFile() {
    // player.clear(Uri.parse(widget.musicfile));
    // audioPlayer.stop(); // stop the file like this
    assetsAudioPlayer.stop();
    return;
  }
}
