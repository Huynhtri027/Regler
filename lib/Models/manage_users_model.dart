import 'dart:convert';

import 'package:flutter_app/Classes/user_data.dart';
import 'package:flutter_app/Classes/gen_string.dart';
import 'package:http/http.dart' as http;

class ManageUsersModel {
  
  // List<UserData> getData() {
  //   return user;
  // }

  Future<bool> blockUser(UserData user) async
  {
    String url=GenerateString.genStringBlock(user.id.toString());
    var res = await http.get(
      Uri.encodeFull(url),
    );
    if(res.body.toString()=='success')
    {
      return true;
    }
    else{
      return false;
    }
    
  }

  Stream<List<UserData>> setData() async* {
    List<UserData> user = new List<UserData>();
    String url = GenerateString.genStringMngUsers();
    var response = await http.get(
      Uri.encodeFull(url),
    );
    List data = jsonDecode(response.body);

    //print(response.body);

    for (int i = 0; i < data.length; i++) {
      bool f = false;

      if (data[i]['isblocked'] == '1') {
        f = true;
      }

      UserData userData = UserData(
        id: int.parse(data[i]['id']),
        name: data[i]['u_name'],
        institute: data[i]['institute'],
        url: data[i]['image_url'],
        role: data[i]['type'],
        isBlcked: f,
        limit: int.parse(data[i]['user_limit']),
        used: int.parse(data[i]['user_use']),
        bal: int.parse(data[i]['balence']),
      );
      user.add(userData);
    }
    yield user;
  }
}
