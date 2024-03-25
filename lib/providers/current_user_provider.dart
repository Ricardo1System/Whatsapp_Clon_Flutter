

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/models/user/user_dto.dart';

class CurrentUserProvider extends ChangeNotifier {
   late UserDto _user;

   UserDto get loadUserProperties => _user;

   set loadUserProperties(UserDto user){
      _user = user;
      notifyListeners();
   }
   
   void updateProfileUrl(String url){
    UserDto userUpdate= _user.copyWith(
        urlImageProfile: url
      );
      _user = userUpdate;
      notifyListeners();
   }
  
}