import 'package:flutter/material.dart';
import 'package:hat/theme/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Настройки игры"),
          backgroundColor: Colors.blue,
          centerTitle: true,),
        backgroundColor: AppColors.bg,
        body: Container (
          child: Text ('\n'
              '\n В РАЗРАБОТКЕ У СОЗДАТЕЛЯ :) '
              '\n   Настройки темы (светлая, тёмная, разноцветная)'
              '\n  Настройки времени раундов'
              '\n  Игра без штрафов'
              '\n  Звук старта'
              '\n  Звук сирены об окончинии времени'),
        )
    );
  }
}
