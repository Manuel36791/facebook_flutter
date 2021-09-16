// ignore_for_file: use_key_in_widget_constructors

import 'package:community_material_icon/community_material_icon.dart';
import 'package:facebook_flutter/modules/home/home_screen.dart';
import 'package:facebook_flutter/shared/components/components.dart';
import 'package:facebook_flutter/shared/components/constants.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
  ];
  final List<IconData> icons = [
    Icons.home,
    Icons.ondemand_video,
    CommunityMaterialIcons.account_circle_outline,
    CommunityMaterialIcons.account_group_outline,
    CommunityMaterialIcons.bell_outline,
    Icons.menu,
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: icons.length,
      child: Scaffold(
        appBar: MakeResponsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: myAppBar(
                  currentUser: currentUser,
                  icon: icons,
                  selectedIndex: selectedIndex,
                  onTap: (index) => setState(() => selectedIndex = index),
                ),
              )
            : null,
        body: IndexedStack(
          index: selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: !MakeResponsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: myTabBar(
                  icons: icons,
                  selectedIndex: selectedIndex,
                  onTap: (index) => setState(() => selectedIndex = index),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
