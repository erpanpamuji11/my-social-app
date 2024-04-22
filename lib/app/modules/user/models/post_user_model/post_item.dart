import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/owner.dart';
part 'post_item.g.dart';

@HiveType(typeId: 1)
class PostItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String image;
  @HiveField(2)
  final int likes;
  @HiveField(3)
  final List<dynamic> tags;
  @HiveField(4)
  final String text;
  @HiveField(5)
  final DateTime publishDate;
  @HiveField(6)
  final String userName;
  @HiveField(7)
  final String ownerPic;

  PostItem(
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.userName,
    this.ownerPic,
  );
}
