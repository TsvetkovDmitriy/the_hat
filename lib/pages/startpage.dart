import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hat/main.dart';
import 'package:hat/pages/playerspage.dart';
import 'package:hat/pages/teamspage.dart';
import 'package:hat/pages/rulespage.dart';
import 'package:hat/pages/settings.dart';

import '../data/data.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  void initState() {
    super.initState();
    // controller = AnimationController(
    //   duration: const Duration(seconds: 10),
    //   vsync: this,
    // )
    //   ..repeat();
    // animation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff51D3FE),
              Color(0xff019AF6),
            ],
          )),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                  right: -70,
                  top: -30,
                  child: Image.asset(
                    'assets/FirstScreen 3d.png',
                    fit: BoxFit.fill,
                    width: 429,
                    height: 539,
                  )),
              Column(
                children: [
                  const SizedBox(
                    height: 470,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Шляпа",
                          style: AppTextStyles.hed,
                          // Theme.of(context).textTheme.bodyText1?.copyWith(
                          //     color: Colors.white,
                          //     fontSize: 28,
                          //     fontWeight: FontWeight.w700,)
                          // GoogleFonts.mon(
                          //
                          //
                          //   color: Colors.white,
                          //   fontSize: 28,
                          //   fontWeight: FontWeight.w700,
                          //   letterSpacing: 2,
                          // ),
                        ),
                        // SizedBox(
                        //   height: 0,
                        // ),
                        Text(
                          "Играйте со своими друзьями \nи близкими",
                          style: AppTextStyles.nohed,
                          textAlign: TextAlign.center,
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(30.0),
                        //   child: AnimatedBuilder(
                        //       animation: animation,
                        //       child: Image.asset('assets/Hat.png'),
                        //       builder: (BuildContext context, Widget? child) {
                        //         return Transform.rotate(
                        //           angle: animation.value, //* 2.0 * math.pi,
                        //           child: child,
                        //         );
                        //       }),
                        // ),                   Это анимация вращения
                        ElevatedButton(
                          onPressed: () {
                            api.game = Game();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const TeamsPage()));
                          },
                          
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.bg),
                              padding: MaterialStateProperty.all(const EdgeInsets.only(
                                  left: 70, top: 15, right: 70, bottom: 15)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: AppColors.bg)))),
                          child: const Text(
                            'Играть',
                            style: TextStyle(
                                color: Color(0xFF019AF6),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const RulesPage()));
                          },
                          
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(const EdgeInsets.only(
                                  left: 46, top: 15, right: 46, bottom: 15)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: AppColors.bg, width: 1))),
                              shadowColor: MaterialStateProperty.all(Colors.grey),
                              elevation: MaterialStateProperty.all(0)),
                          child: const Text('Правила игры',
                              style: TextStyle(
                                  color: AppColors.bg,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        // ElevatedButton(
                        //   onPressed: () {
                        //     Navigator.of(context).push(
                        //         MaterialPageRoute(builder: (context) => Settings()));
                        //   },
                        //   child: const Text('Настройки',
                        //       style: TextStyle(
                        //           color: Colors.black38,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w600)),
                        //   style: ButtonStyle(
                        //       backgroundColor:
                        //           MaterialStateProperty.all(Colors.blueGrey),
                        //       padding: MaterialStateProperty.all(EdgeInsets.only(
                        //           left: 44, top: 15, right: 44, bottom: 15)),
                        //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //           side: BorderSide(color: Colors.black38, width: 2))),
                        //       shadowColor: MaterialStateProperty.all(Colors.grey),
                        //       elevation: MaterialStateProperty.all(0)),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Settings()));
            },
            child: Image.asset('assets/set.png')));
  }
}
