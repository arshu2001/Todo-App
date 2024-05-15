// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var password = TextEditingController();
  var emil = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();
  var place = TextEditingController();
  var selectedvalue = '';
  Future<void> pro() async {
    final profile =
        await FirebaseFirestore.instance.collection('pro content').add({
      'name': name.text,
      'emil': emil.text,
      'password': password.text,
      'phone': phone.text,
      'address': address.text,
      'place': place.text,
      'genter': selectedvalue
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
      ),
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
                      hintText: 'enter name', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
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
                      hintText: 'enter email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'please enter email';
                    }
                    if (!RegExp(r'^(?=.*[a-z])(?=.*[0-9].*@)')
                        .hasMatch(value!)) {
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
                      hintText: 'enter password', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'please enter password';
                    }
                    if (!RegExp(r'^(?=.*[0-9]).{8,}$').hasMatch(value!)) {
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
                      hintText: 'phone', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'please enter phone number';
                    }
                    if (!RegExp(r'^(?=.*[0-9]).{10,}$').hasMatch(value!)) {
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
                      hintText: 'enter Address', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
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
                      hintText: 'enter place', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'please enter place';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: RadioListTile(
                        title: Text('Male'),
                        value: 'Male',
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioListTile(
                        title: Text('Female'),
                        value: 'Female',
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: RadioListTile(
                        title: Text('Others'),
                        value: 'Others',
                        groupValue: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      pro();
                    }
                  },
                  child: Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}
