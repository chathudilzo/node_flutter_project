import 'dart:convert';
import 'package:daily_class/blocs/home/home_page.dart';
import 'package:daily_class/blocs/register/register_page.dart';
import 'package:daily_class/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs()async{
    prefs=await SharedPreferences.getInstance();
  }
void loginUser()async{
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

    var response=await http.post(Uri.parse(login),
    headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
      },
    body:jsonEncode(regBody));

    var jsonResponse=jsonDecode(response.body);
    print(jsonResponse['status']);

    if(jsonResponse['status']){
      var myToken=jsonResponse['token'];
      prefs.setString('token', myToken);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>HomePage(token: myToken,)));
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
              Text('LogIn',style: TextStyle(fontSize: 20),),
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
                    loginUser();
                  },
                  child: Container(
                    
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Login'),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                      
                    }, child: Text('Register'))
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}