import 'dart:io';

import 'package:citchat/pages/home/chat/message_page.dart';
import 'package:citchat/pages/home/contact/contact_page.dart';
import 'package:citchat/pages/home/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../shared/theme.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    _cekPermission();
    super.initState();
  }

  Future<void> _cekPermission() async {
    final PermissionStatus result;
    
    if (Platform.isAndroid) {
      result = await Permission.storage.request();
    } else {
      result = await Permission.photos.request();
    }
    if (result.isDenied) {
      await Permission.storage.request();
      await Permission.photos.request();
    }
  }

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
          ProfilePage()
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
              icon: Icon(HeroIcons.users),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Iconsax.setting_3),
            ),
          ],
          currentIndex: currentIndex,
          onTap: _onItemTapped
      )
    );
  }
}
