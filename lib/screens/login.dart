import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/screens/forget.dart';
import 'package:firebase1/screens/page1.dart';
import 'package:firebase1/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey=GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  Future<void> _savedata(String data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('storeId', data);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 300),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'enter Email Id',
                        
                        border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'please enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: 'enter password',
                        border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'please enter password';
                        }
                        if(!RegExp(r'^(?=.*[0-9].*)').hasMatch(value!)){
                          return 'email must contain alphabat and numbers';
                        }
                        return null;
                      },
                    ), 
                  ),
                  TextButton(onPressed: () {
                    if (formKey.currentState!.validate()){
                      String Email = email.text.trim();
                      
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                  }, child: Text('sign in')),
                  
                  ElevatedButton(onPressed: () async {
                    if(formKey.currentState?.validate() ?? false){
                      String email1 = email.text.trim();
                      String password1 = password.text.trim();
                      var querysnap = await FirebaseFirestore
                      .instance.collection("register")
                      .where('Email',isEqualTo: email1)
                      .limit(1)
                      .get();

                    if (querysnap.docs.isNotEmpty){
                      var userdata = querysnap.docs.first.data();
                      if (userdata['Password']== password1){
                        var storeId = userdata['storeId'] as String?;
                        if (storeId != null){
                        await _savedata(storeId);
                        }
                        
                      }
                       
                      
                    }  
                     
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Page1(),));
                  }, child: Text('submit')),

                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword(),));
                  }, child: Text('Forget Password1')),

                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword(),));
                  }, child: Text('Forget Password2')),



                ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }
}