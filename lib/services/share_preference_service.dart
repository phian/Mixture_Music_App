import 'package:hive/hive.dart';

class SharePrefService {
  const SharePrefService();

  final _authType = 'authType';
  final _authUserName = 'authUserName';
  final _authUserAvatar = 'authUserAvatar';

  Future<void> saveAuthType(String authType) async {
    var authTypeBox = await Hive.openBox(_authType);
    return await authTypeBox.put('authType', authType);
  }

  Future<String> getAuthType() async {
    var userNameBox = await Hive.openBox(_authType);
    var authType = userNameBox.get('authType');

    return authType;
  }

  Future<void> updateAuthType(String newType) async {
    var authTypeBox = await Hive.openBox(_authType);
    return await authTypeBox.putAt(0, newType);
  }

  Future<int> removeAuthType() async {
    var authTypeBox = await Hive.openBox(_authType);
    return await authTypeBox.clear();
  }

  Future<void> saveAuthUserName(String userName) async {
    var authUserBox = await Hive.openBox(_authUserName);
    return await authUserBox.put('userName', userName);
  }

  Future<String> getAuthUserName() async {
    var authUserBox = await Hive.openBox(_authUserName);
    var userName = authUserBox.get('userName');

    return userName;
  }

  Future<void> updateAuthUserName(String newUserName) async {
    var authUserBox = await Hive.openBox(_authUserName);
    return await authUserBox.putAt(0, newUserName);
  }

  Future<int> removeAuthUserName() async {
    var authUserBox = await Hive.openBox(_authUserName);
    return await authUserBox.clear();
  }

  Future<void> saveAuthUserAvatar(String avatarUrl) async {
    var authUserBox = await Hive.openBox(_authUserAvatar);
    return await authUserBox.put('userAvatar', avatarUrl);
  }

  Future<String> getAuthUserAvatar() async {
    var authUserBox = await Hive.openBox(_authUserAvatar);
    var userName = authUserBox.get('userAvatar');

    return userName;
  }

  Future<void> updateAuthUserAvatar(String newAvatarUrl) async {
    var authUserBox = await Hive.openBox(_authUserAvatar);
    return await authUserBox.putAt(0, newAvatarUrl);
  }

  Future<int> removeAuthUserAvatar() async {
    var authUserBox = await Hive.openBox(_authUserAvatar);
    return await authUserBox.clear();
  }
}
