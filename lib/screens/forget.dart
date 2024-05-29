import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/screens/curd.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  String Email;
  ForgetPassword({super.key,required this.Email});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  
  @override
  Widget build(BuildContext context) {
    final formKey=GlobalKey<FormState>();
    // var email = TextEditingController();
    var password =TextEditingController();
    var cpassword = TextEditingController();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Align(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextFormField(
                  // controller: email,
                  decoration: InputDecoration(
                    hintText: 'email',
                    enabledBorder: OutlineInputBorder()
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(top: 10),
                 child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder()
                    ),
                    validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter new password';
                }
                return null;
              },
                  ),
                             ),
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 10),
                 child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: cpassword,
                    decoration: InputDecoration(
                      hintText: 'Conform Password',
                      enabledBorder: OutlineInputBorder()
                    ),
                     validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter password';
                }
                return null;
              },
                  ),
                             ),
               ),
               ElevatedButton(onPressed: () async{
                 if(cpassword.text == password.text){
                  print('equal');
                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('register')
                  .where('Email',isEqualTo: widget.Email)
                  .get();
                 if(querySnapshot.docs.isNotEmpty){
                  DocumentReference userDocRef =
                  querySnapshot.docs.first.reference;
                  await userDocRef.update({
                    'Password' : password.text
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: 
                              Text('Password Updated'),
                          ),
                        );
                   Navigator.pop(context) ;
                   Navigator.push(context, MaterialPageRoute(builder: (context) => TodoScreen(),));
                 } 
                 
                 }
                 else{
                   ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: 
                              Text('Password does not match'),
                          ),
                        );
                 }
               }, child: Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}