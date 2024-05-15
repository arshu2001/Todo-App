// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey=GlobalKey<FormState>();
  var name = TextEditingController();
  var password = TextEditingController();
  var emil = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var place = TextEditingController();  
  Future <void> samp() async{
    if (formKey.currentState!.validate()){
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emil.text, password: password.text);
        String uid = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection("register").add({
          'Name': name.text,
          'Email': emil.text,
          'Password': password.text,
          'Phone': phone.text,
          'Address': address.text,
          'Place' : place.text
        });
        print("Register Successfully");
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
      }catch (e){
        print("unexpected error during Registration");
        Fluttertoast.showToast(
          msg: "unexpected error during Registration",
          toastLength: Toast.LENGTH_LONG,
          gravity:  ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 250,
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'enter name',
                    
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value?.isEmpty ?? true){
                      return 'please enter name';
                    }
                    
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: TextFormField(
                  controller: emil,
                  decoration: InputDecoration(
                    hintText: 'enter email',
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value?.isEmpty ?? true){
                      return 'please enter email';
                    }
                    if(!RegExp(r'^(?=.*[a-z])(?=.*[0-9].*@)').hasMatch(value!)){
                      return 'email must contain alphabat and numbers';
                    }
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
                    if(value?.isEmpty ?? true){
                      return 'please enter password';
                    }
                    if(!RegExp(r'^(?=.*[0-9]).{8,}$').hasMatch(value!)){
                      return 'phone number must contain 10 numder ';
                    }
                  },
                ),
              ),
               SizedBox(
                height: 50,
                width: 250,
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    hintText: 'phone',
                    
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value?.isEmpty ?? true){
                      return 'please enter phone number';
                    }
                    if(!RegExp(r'^(?=.*[0-9]).{10,}$').hasMatch(value!)){
                      return 'phone number must contain 10 numder ';
                    }
                    
                  },
                ),
              ),
               SizedBox(
                height: 50,
                width: 250,
                child: TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    hintText: 'enter Address',
                    
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value?.isEmpty ?? true){
                      return 'please enter Address';
                    }
                    
                  },
                ),
              ),
               SizedBox(
                height: 50,
                width: 250,
                child: TextFormField(
                  controller: place,
                  decoration: InputDecoration(
                    hintText: 'enter place',
                    
                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value?.isEmpty ?? true){
                      return 'please enter place';
                    }
                    
                  },
                ),
              ),
              ElevatedButton(onPressed: () {
                if(formKey.currentState?.validate() ?? false){
                  samp();
                }
              }, child: Text('submit'))
            ],

          ),
        ),
      ),
    );
  }
}