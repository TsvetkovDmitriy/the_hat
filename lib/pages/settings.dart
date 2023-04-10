import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        appBar: AppBar(
          leadingWidth: 70,
          title: const Text('Настройки игры',
            style: TextStyle(color: AppColors.pink),),
          leading: IconButton(
            icon: SvgPicture.asset('assets/back_button.svg'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          backgroundColor: AppColors.bg,),
        backgroundColor: AppColors.bg,
        body: Container (
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text (
                '  В РАЗРАБОТКЕ У СОЗДАТЕЛЯ :) '
                '\nНастройки темы (светлая, тёмная, разноцветная)'
                '\nНастройки времени раундов'
                '\nИгра без штрафов'
                '\nЗвук старта'
                '\nЗвук сирены об окончинии времени'
                '\n'
                '\n  ВСЕ ПРЕДЛОЖЕНИЯ И ПОЖЕЛАНИЯ С ЖДУ С НЕТЕРПЕНИЕМ'),
          ),
        )
    );
  }
}
