
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {

  Future<bool> getToken() async{
    print('Entre al repository');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if(token != null){
      print('tiene usuario');
      return true;
    }else{
      print('No tiene usuario');
      return false;
    }
  }
}