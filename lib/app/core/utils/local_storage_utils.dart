import 'package:get_storage/get_storage.dart';
import 'package:mysocial_app/app/core/constants/local_storage_constant.dart';
import 'package:mysocial_app/app/modules/user/models/post_user_model/post_user_model.dart';

class LocalStorageUtil {
  // static String? getToken() => GetStorage().read<String?>("token");

  // static Future setToken(String token) async =>
  //     await GetStorage().write("token", token);

  static Future setPost(PostUserModel? user) =>
      GetStorage().write(LocalStorageConstant.post, user?.toJson());

  static PostUserModel? getPost() {
    final map = GetStorage().read(LocalStorageConstant.post) ?? {};
    return PostUserModel.fromJson(map);
  }

  static deletePost() {
    return GetStorage().remove(LocalStorageConstant.post);
  }

  static Future<void> removeAllKey() => GetStorage().erase();

  // * add more getter and setter for shared preferences

  static bool hasData(String key) => GetStorage().hasData(key);
}
