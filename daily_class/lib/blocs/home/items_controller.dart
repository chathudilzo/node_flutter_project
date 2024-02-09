import 'dart:convert';

import 'package:daily_class/config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ItemController extends GetxController{
  RxList <Map<String,dynamic>> todoList=<Map<String,dynamic>>[].obs;
  RxBool isLoading=false.obs;



  void  getTodo(String userId)async{
    try{
      isLoading.value=true;
      print(userId);
      var regBody={
        "userId":userId
      };

      var response=await http.post(Uri.parse(getToDoList),
    headers: {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
      },
    body:jsonEncode(regBody));

    var jsonResponse=jsonDecode(response.body);
    todoList.clear();

    for(var item in jsonResponse['success']){
      todoList.add(item);
    }
    isLoading.value=false;
    print(todoList);

    }catch(error){
      print(error);
    }
  }


  void deleteTask(String id,String userId)async{
    try{
      isLoading.value=true;
      var regBody={
        "id":id
      };
      var response=await http.post(Uri.parse(deleteTodo),
      headers: {
    'Content-Type': 'application/json',
    'Charset': 'utf-8'
      },
      body: jsonEncode(regBody));

      var jsonResponse=jsonDecode(response.body);

      if(jsonResponse['status']){
        getTodo(userId);
      }else{
        isLoading.value=false;
      }
    }catch(error){
      print(error);
      isLoading.value=false;
    }
  }
}