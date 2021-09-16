import 'package:facebook_flutter/models/user_model.dart';

class StoryModel {
  UserModel user;
  String imageUrl;
  bool isViewed;

  StoryModel({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}
