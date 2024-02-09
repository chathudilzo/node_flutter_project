import 'dart:convert';

import 'package:daily_class/blocs/home/items_controller.dart';
import 'package:daily_class/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
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
ItemController itemController=Get.find();

void createTask()async{
 try{
    if(titleController.text.isNotEmpty && descController.text.isNotEmpty){
      var regBody={
        "userId":userId,
        "title":titleController.text,
        "desc":descController.text,
      };
      var response=await http.post(Uri.parse(addtodo)
      ,headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
      },body: jsonEncode(regBody));

      var jsonResponse=jsonDecode(response.body);

      print(jsonResponse);
      if(jsonResponse['status']){
        Navigator.pop(context);
        titleController.clear();
        descController.clear();
        itemController.getTodo(userId);
      }

    }else{
      print('cannot be empty');
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
    itemController.getTodo(userId);
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return  Scaffold(
      body: Container(
        width: width,
        height:height,
        child: Stack(children: [
          Container(
            width: width,
            height: 0.5*height,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blueAccent,Colors.purpleAccent])
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left:50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    
                     Container(
                      width: width*0.2,
                      height: width*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [BoxShadow(
                          blurRadius: 1,spreadRadius: 1,offset: Offset(1, 2)
                        )],
                        color: Color.fromARGB(255, 13, 99, 114)
                      ),
                      child: Center(child: 
                      IconButton(onPressed: (){}, icon:Icon(Icons.menu,size: 40,color: Colors.white,),),
                     ) 
                      
                    ),
                    SizedBox(height: 10,),
                    Text('Mongo + Task App',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50))
              ),
            height: height*0.6,
            width: width,
            child:Obx((){
              if(itemController.todoList.isEmpty && itemController.isLoading.value==false){
                return Center(child: Text('No items Found'),);
              }else if(itemController.isLoading.value){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                return ListView.builder(
                  itemCount: itemController.todoList.length,
                  itemBuilder:(contex,index){
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(motion:ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: (){}),
                     children:[
                      SlidableAction(
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (BuildContext context){
                        itemController.deleteTask(itemController.todoList[index]['_id'],userId);
                      })
                     ]),
                    child: Card(
                      
                      child: ListTile(
                        leading: Icon(Icons.add_task),
                        title: Text(itemController.todoList[index]['title'],style: TextStyle(color: Colors.black),),
                        trailing: Icon(Icons.arrow_back),
                      ),
                    ));
                });
              }
            }) ,
          )
          )
        ]),
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
            createTask();
          }, child: Text('Add'))
        ],
      );
     });
  }
}