// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:community_material_icon/community_material_icon.dart';
import 'package:facebook_flutter/shared/colors/colors.dart';
import 'package:facebook_flutter/shared/components/components.dart';
import 'package:facebook_flutter/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: MakeResponsive(
          desktop:
              homeScreenDesktop(scrollController: trackingScrollController),
          mobile: homeScreenMobile(scrollController: trackingScrollController),
        ),
      ),
    );
  }
}

Widget homeScreenMobile({TrackingScrollController? scrollController}) {
  return CustomScrollView(
    controller: scrollController,
    slivers: [
      SliverAppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
        title: const Text(
          'Facebook',
          style: TextStyle(
            color: MyPallette.facebookBlue,
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
            letterSpacing: -1.2,
          ),
        ),
        centerTitle: false,
        floating: true,
        actions: [
          circleButtonItem(
            icon: Icons.search,
            iconSize: 30.0,
            onPressed: () {},
          ),
          circleButtonItem(
            icon: CommunityMaterialIcons.facebook_messenger,
            iconSize: 30.0,
            onPressed: () {},
          ),
        ],
      ),
      SliverToBoxAdapter(
        child: createPostItem(currentUser: currentUser),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
        sliver: SliverToBoxAdapter(
          child: roomsItem(onlineUsers: onlineUsers),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
        sliver: SliverToBoxAdapter(
          child: storyItem(
            currentUser: currentUser,
            stories: stories,
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return postItem(index: index);
          },
          childCount: posts.length,
        ),
      )
    ],
  );
}

Widget homeScreenDesktop({TrackingScrollController? scrollController}) {
  return Row(
    children: [
      Flexible(
        flex: 2,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: optionsList(currentUser: currentUser),
          ),
        ),
      ),
      const Spacer(),
      Container(
        width: 600.0,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
              sliver: SliverToBoxAdapter(
                child: storyItem(
                  currentUser: currentUser,
                  stories: stories,
                ),
              ),
            ),
            SliverToBoxAdapter(child: createPostItem(currentUser: currentUser)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              sliver: SliverToBoxAdapter(
                child: roomsItem(onlineUsers: onlineUsers),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  //final PostModel post = posts[index];
                  return postItem(
                    index: posts[index],
                  );
                },
                childCount: posts.length,
              ),
            )
          ],
        ),
      ),
      const Spacer(),
      Flexible(
        flex: 2,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: contactList(userModel: onlineUsers),
          ),
        ),
      ),
    ],
  );
}
