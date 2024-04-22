import 'package:hive_flutter/hive_flutter.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_item.dart';

class PostService {
  final String _boxName = "postBox";

  Future<Box<PostItem>> get _box async =>
      await Hive.openBox<PostItem>(_boxName);

  Future<void> addPost(PostItem item) async {
    var box = await _box;
    await box.add(item);
  }

  Future<List<PostItem>> getAllPost() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deletePost(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }
}
