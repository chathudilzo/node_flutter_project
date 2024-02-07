import 'dart:convert';

import 'package:daily_class/config.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key,required this.token});
  final token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
late String email;
late String userId;
TextEditingController titleController=TextEditingController();
TextEditingController descController=TextEditingController();

void createTask()async{
 try{
   if(titleController.text.isNotEmpty && descController.text.isNotEmpty){
    var regBody={
      "userId":userId,
      "title":titleController.text,
      "desc":descController.text,
    };
    var response=await http.post(Uri.parse(addtodo),headers:{"Content-Type":'application/json'},body: regBody);

    var jsonResponse=jsonDecode(response.body);

    print(jsonResponse);

  }
 }catch(error){
  print(error);
 }
}


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken=JwtDecoder.decode(widget.token);
    email=jwtDecodedToken['email'];
    userId=jwtDecodedToken['_id'];
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(email)
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _displayTextInputDialog(context);
      },child: Icon(Icons.add),),
    );
  }


  Future<void> _displayTextInputDialog(BuildContext context)async{
    
    return showDialog(context: context,
     builder: (context){
      return AlertDialog(
        title: Text('Add Tasks'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            SizedBox(height: 10,),
             TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
          ],
          
        ),
        actions: [
          TextButton(onPressed: (){

          }, child: Text('Add'))
        ],
      );
     });
  }
}