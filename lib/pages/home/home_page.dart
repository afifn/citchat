import 'package:citchat/pages/home/chat/message_page.dart';
import 'package:citchat/pages/home/contact_page.dart';
import 'package:citchat/pages/home/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../shared/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          MessagePage(),
          ContactPage(),
          SettingPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: monsterratTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          unselectedLabelStyle: monsterratTextStyle.copyWith(
            fontSize: 10,
            fontWeight: medium,
          ),
          items: const [
            BottomNavigationBarItem(
              label: "Messages",
              icon: Icon(Iconsax.message),
            ),
            BottomNavigationBarItem(
              label: "Peoples",
              icon: Icon(Iconsax.people),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Iconsax.setting_3),
            ),
          ],
          currentIndex: currentIndex,
          onTap: _onItemTapped
      )
    );
  }
}
