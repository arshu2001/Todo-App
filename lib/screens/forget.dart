import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
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
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder()
                  ),
                ),
                           ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 10),
               child: SizedBox(
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Conform Password',
                    enabledBorder: OutlineInputBorder()
                  ),
                ),
                           ),
             ),
             ElevatedButton(onPressed: () {
               
             }, child: Text('submit'))
          ],
        ),
      ),
    );
  }
}