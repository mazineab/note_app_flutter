import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefManager extends GetxService{
  late SharedPreferences pref;

  Future<SharedPrefManager> init()async{
    pref=await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> saveString(String key,String val)async{
    try{
      await pref.setString(key,val);
      return true;
    }
    catch(e){
      return false;
    }
  }

  String? getString(String key){
    return pref.getString(key);
  }

  Future<bool> remove(String key)async{
    try{
      return await pref.remove(key);
    }
    catch(e){
      return false;
    }
  }
}