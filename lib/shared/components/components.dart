import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:facebook_flutter/models/post_model.dart';
import 'package:facebook_flutter/models/story_model.dart';
import 'package:facebook_flutter/models/user_model.dart';
import 'package:facebook_flutter/shared/colors/colors.dart';
import 'package:facebook_flutter/shared/cubit/cubit.dart';
import 'package:facebook_flutter/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

Widget circleButtonItem({
  required IconData? icon,
  required double? iconSize,
  required Function? onPressed,
}) =>
    Container(
      margin: const EdgeInsets.all(6.0),
      decoration:
          BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {
          onPressed!();
        },
        iconSize: iconSize!,
        color: Colors.black87,
      ),
    );

Widget contactList({
  required List<UserModel>? userModel,
}) =>
    Container(
      constraints: const BoxConstraints(maxWidth: 280.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Contacts',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.grey[600],
              ),
              const SizedBox(
                width: 8.0,
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.grey[600],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                itemCount: userModel!.length,
                itemBuilder: (BuildContext context, int index) {
                  final UserModel user = userModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: userCardItem(
                      userModel: user,
                    ),
                  );
                }),
          )
        ],
      ),
    );

Widget createPostItem({
  context,
  required UserModel? currentUser,
}) =>
    Card(
      margin: EdgeInsets.symmetric(
          horizontal: MakeResponsive.isDesktop(context)
              ? 0.5
              : 0.0), // to make shadow appears
      elevation: MakeResponsive.isDesktop(context) ? 1.0 : 0.0,
      shape: MakeResponsive.isDesktop(context)
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
          : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                profileAvatarItem(
                  imageUrl: currentUser!.imageUrl,
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: 'What\'s on your mind?'),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 0.5,
              height: 10.0,
            ),
            SizedBox(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () => print('live'),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: const Text('Live'),
                  ),
                  const VerticalDivider(
                    width: 8.0,
                  ),
                  TextButton.icon(
                    onPressed: () => print('Photo'),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: const Text('Photo'),
                  ),
                  const VerticalDivider(
                    width: 8.0,
                  ),
                  TextButton.icon(
                    onPressed: () => print('Room'),
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.purpleAccent,
                    ),
                    label: const Text('Room'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget myAppBar({
  required UserModel? currentUser,
  required List<IconData>? icon,
  required int? selectedIndex,
  required Function(int)? onTap,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'Facebook',
              style: TextStyle(
                color: MyPallette.facebookBlue,
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
                letterSpacing: -1.2,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: myTabBar(
              icons: icon,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                userCardItem(
                  userModel: currentUser!,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                circleButtonItem(
                  icon: Icons.search,
                  iconSize: 30.0,
                  onPressed: () {},
                ),
                circleButtonItem(
                  icon: CommunityMaterialIcons.facebook_messenger,
                  iconSize: 30.0,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget myTabBar({
  required List<IconData>? icons,
  required int? selectedIndex,
  required Function(int)? onTap,
  bool isBottomIndicator = false,
}) =>
    TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
        border: isBottomIndicator
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFF1777F2) /*MyPallette.facebookBlue*/,
                  width: 3.0,
                ),
              )
            : const Border(
                top: BorderSide(
                  color: Color(0xFF1777F2) /*MyPallette.facebookBlue*/,
                  width: 3.0,
                ),
              ),
      ),
      tabs: icons!
          .asMap()
          .map((i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == selectedIndex
                        ? MyPallette.facebookBlue
                        : Colors.black45,
                    size: 30.0,
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );

List<List> moreOptionsList = [
  [
    CommunityMaterialIcons.shield_account,
    Colors.deepPurple,
    'COVID-19 Info Center'
  ],
  [CommunityMaterialIcons.account_multiple, Colors.cyan, 'Friends'],
  [
    CommunityMaterialIcons.facebook_messenger,
    MyPallette.facebookBlue,
    'Messenger'
  ],
  [CommunityMaterialIcons.flag, Colors.orange, 'Pages'],
  [CommunityMaterialIcons.storefront, MyPallette.facebookBlue, 'Marketplace'],
  [Icons.ondemand_video, MyPallette.facebookBlue, 'Watch'],
  [CommunityMaterialIcons.calendar_star, Colors.red, 'Events'],
];

Widget optionsList({
  required UserModel? currentUser,
}) =>
    Container(
      constraints: const BoxConstraints(maxWidth: 280.0),
      child: ListView.builder(
          itemCount: 1 + moreOptionsList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: userCardItem(
                  userModel: currentUser!,
                ),
              );
            }
            final List listOptions =
                moreOptionsList[index - 1]; //because it's zero index
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: options(
                  icon: listOptions[0],
                  color: listOptions[1],
                  label: listOptions[2]),
            );
          }),
    );

Widget options({
  required IconData? icon,
  required Color? color,
  required String? label,
}) =>
    InkWell(
      onTap: () => print(label),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30.0,
            color: color,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Flexible(
            child: Text(
              label!,
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );

Widget postItem({
  index,
}) =>
    BlocProvider(
      create: (context) => AppCubit()..getPosts(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Conditional.single(
            context: context,
            conditionBuilder: (context) => cubit.postFetch.isNotEmpty,
            widgetBuilder: (context) => Card(
              margin: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: MakeResponsive.isDesktop(context) ? 0.5 : 0.0),
              // to make shadow appears
              elevation: MakeResponsive.isDesktop(context) ? 1.0 : 0.0,
              shape: MakeResponsive.isDesktop(context)
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : null,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          postHeader(postModel: cubit.postFetch[index]),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(cubit.postFetch[index].caption!),
                          cubit.postFetch[index].imageUrl != null
                              ? const SizedBox.shrink()
                              : const SizedBox(
                                  height: 6.0,
                                ),
                        ],
                      ),
                    ),
                    cubit.postFetch[index].imageUrl != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CachedNetworkImage(
                                imageUrl: cubit.postFetch[index].imageUrl!),
                          )
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: postStatus(postModel: cubit.postFetch[index]),
                    ),
                  ],
                ),
              ),
            ),
            fallbackBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );

Widget postHeader({
  required PostModel? postModel,
}) =>
    Row(
      children: [
        profileAvatarItem(
          imageUrl: postModel!.user!.imageUrl,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postModel.user!.name!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    '${postModel.timeAgo} ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                  ),
                  Icon(
                    Icons.public,
                    size: 12.0,
                    color: Colors.grey[600],
                  )
                ],
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_horiz,
          ),
        ),
      ],
    );

Widget postStatus({
  required PostModel? postModel,
}) =>
    Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: MyPallette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                '${postModel!.likes} ',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '${postModel.comments} Comments',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '${postModel.shares} Shares',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            postButton(
              icon: Icon(
                CommunityMaterialIcons.thumb_up_outline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: () => print('post liked'),
            ),
            postButton(
              icon: Icon(
                CommunityMaterialIcons.comment_outline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () => print('commented'),
            ),
            postButton(
              icon: Icon(
                CommunityMaterialIcons.share_outline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => print('post shared'),
            ),
          ],
        ),
      ],
    );

Widget postButton({
  required Icon? icon,
  required String? label,
  required Function? onTap,
}) =>
    Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                const SizedBox(
                  width: 4.0,
                ),
                Text(
                  label!,
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget profileAvatarItem({
  required String? imageUrl,
  bool isActive = false,
  bool hasBorder = false,
}) =>
    Stack(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundColor: MyPallette.facebookBlue,
          child: CircleAvatar(
            radius: hasBorder ? 17.0 : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl!),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: MyPallette.online,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );

Widget roomsItem({
  context,
  required List<UserModel>? onlineUsers,
}) =>
    Card(
      margin: EdgeInsets.symmetric(
          horizontal: MakeResponsive.isDesktop(context)
              ? 0.5
              : 0.0), // to make shadow appears
      elevation: MakeResponsive.isDesktop(context) ? 1.0 : 0.0,
      shape: MakeResponsive.isDesktop(context)
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )
          : null,
      child: Container(
        height: 60.0,
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers!.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                child: createRoomButton(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
              );
            }
            final UserModel user = onlineUsers[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: profileAvatarItem(
                imageUrl: user.imageUrl,
                isActive: true,
              ),
            );
          },
        ),
      ),
    );

Widget createRoomButton() => OutlinedButton(
      onPressed: () => print('Room is created'),
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            width: 3.0,
            color: Colors.blueAccent,
          ),
        ),
        textStyle: const TextStyle(
          color: MyPallette.facebookBlue,
        ),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.video_call,
            size: 35.0,
            color: Colors.purple,
          ),
          SizedBox(
            width: 4.0,
          ),
          Text('Create\nRoom'),
        ],
      ),
    );

Widget storyItem({
  context,
  required UserModel? currentUser,
  required List<StoryModel>? stories,
}) =>
    Container(
      height: 200.0,
      color:
          MakeResponsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + stories!.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: storyCard(
                  context,
                  isAddStory: true,
                  currentUser: currentUser,
                ),
              );
            }
            final StoryModel story = stories[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: storyCard(
                context,
                story: story,
              ),
            );
          }),
    );

Widget storyCard(
  context, {
  bool? isAddStory,
  UserModel? currentUser,
  StoryModel? story,
}) =>
    Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: isAddStory! ? currentUser!.imageUrl! : story!.imageUrl,
            height: double.infinity,
            width: 110.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110.0,
          decoration: BoxDecoration(
            gradient: MyPallette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: MakeResponsive.isDesktop(context)
                ? const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4.0),
                  ]
                : null,
          ),
        ),
        Positioned(
            top: 8.0,
            left: 8.0,
            child: isAddStory
                ? Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      iconSize: 30.0,
                      color: MyPallette.facebookBlue,
                      onPressed: () => print('Story Added'),
                    ),
                  )
                : profileAvatarItem(
                    imageUrl: story!.user.imageUrl,
                    hasBorder: story.isViewed,
                  )),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            isAddStory ? 'Add to Story' : story!.user.name!,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );

Widget userCardItem({
  required UserModel userModel,
}) =>
    InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          profileAvatarItem(
            imageUrl: userModel.imageUrl,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Flexible(
            child: Text(
              userModel.name!,
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

class MakeResponsive extends StatelessWidget {
  Widget? mobile;
  Widget? desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1200;

  MakeResponsive({
    this.mobile,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop!;
        } else {
          return mobile!;
        }
      },
    );
  }
}
