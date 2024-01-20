import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hat/pages/startpage.dart';

import 'data/api.dart';
import 'theme/text_styles.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}
Api api = Api();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Шляпа',
      theme:AppThemeData.light,
      home: StartPage(),
    );
  }
}
 //test