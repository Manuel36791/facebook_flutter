import 'package:facebook_flutter/models/user_model.dart';

class PostModel {
  UserModel? user;
  String? caption;
  String? timeAgo;
  String? imageUrl;
  int? likes;
  int? comments;
  int? shares;

  PostModel({
    this.user,
    this.caption,
    this.timeAgo,
    this.imageUrl,
    this.likes,
    this.comments,
    this.shares,
  });
}
