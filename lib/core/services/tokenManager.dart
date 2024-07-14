import 'package:note_app_flutter/core/utils/localStorage/shared_pref_manager.dart';

class TokenManager {
  static final String tokenKey="token";
  SharedPrefManager prefManager;

  TokenManager(this.prefManager);

  String? get token=>prefManager.getString(tokenKey);

  Future<bool> saveToken(String token)async{
    try{
      await prefManager.saveString(tokenKey,token);
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<void> clearToken()async{
    await prefManager.remove(tokenKey);
  }

  bool isValidToken(){
    final token=prefManager.getString(tokenKey);
    return token!=null;

  }
}