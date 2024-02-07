import 'dart:convert';
import 'dart:math';
import 'package:daily_class/blocs/login/login_page.dart';
import 'package:daily_class/config.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

void registerUser()async{
 try{
 if(emailController.text.isNotEmpty && emailController.text.isNotEmpty){
    setState(() {
      _isNotValidate=false;
    });
    print('tapped');
    var regBody={
      "email":emailController.text,
      "password":passwordController.text
    };

    var response=await http.post(Uri.parse(registration),
    headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
      },
    body:jsonEncode(regBody));

    var jsonResponse=jsonDecode(response.body);
    print(jsonResponse['status']);

    if(jsonResponse['status']){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInPage()));
    }else{
      print('Something wernt wrong');
    }
   
  }else{
    setState(() {
      _isNotValidate=true;
    });
  }
 }catch(error){
  print(error.toString());
 }
}

String _generatePassword(){
  String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String lower = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1234567890';
  String symbols = '!@#\$%^&*()<>,./';

  String password='';
  int passLength=20;
  String seed=upper+lower+numbers+symbols;

  List<String> list=seed.split('').toList();

  Random rand=Random();

  for(int i=0;i<passLength;i++){
    int index=rand.nextInt(list.length);
    password+=list[index];
  }
  return password;

}

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width:width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 200,),
              SizedBox(
                width: width*0.5,
                height: width*0.5,
                child: Image(image: AssetImage('assets/logo.png')),
              ),
              Text('Register',style: TextStyle(fontSize: 20),),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorText: _isNotValidate?"Enter Proper Info":null,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.all(10),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon:IconButton(onPressed: (){
                
                      }, icon:Icon(Icons.remove_red_eye)),
                      prefixIcon: IconButton(onPressed: (){
                        String passGen=_generatePassword();
                        passwordController.text=passGen;
                        setState(() {
                          
                        });
                      }, icon:Icon(Icons.password),
                      
                      ),
                      filled:true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.white),
                      errorText: _isNotValidate? "Enter proper Info":null,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Register'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LogInPage()));
                      
                    }, child: Text('Login'))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}