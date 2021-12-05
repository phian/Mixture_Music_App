import 'package:hive/hive.dart';

class SharePrefService {
  const SharePrefService();

  final _authType = 'authType';

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
}
