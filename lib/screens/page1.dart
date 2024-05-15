import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final formKey=GlobalKey<FormState>();  
  var name = TextEditingController();
  var content = TextEditingController();
  Future <void> click() async{
    final dialogg = await FirebaseFirestore.instance.collection('dialogpage').add(
      {
        'name': name.text,
        'password':content.text,

      }
    ); //adding data to firebase
  }
  Future <void> fire1() async{
    final edit = await FirebaseFirestore.instance.collection('editpage').add(
      {
        'name':name.text,
        'password': content.text
      }
    );
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
     
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(
                  width: 350,
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    tileColor: Colors.grey,
                    title: Text('Arshad'),
                    trailing: Wrap(
                      children:[ 
                        IconButton(onPressed: () {
                         showDialog(context: context, builder: (BuildContext context) {
                           return AlertDialog(
                           title: TextFormField(
                            controller: name,
                             decoration: InputDecoration(
                             border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: 'name'
                        ),
                        validator: (value) {
                           if(value?.isEmpty ?? true){
                          return 'please enter name';
                        }
                        },
                           ),
                           content: TextFormField(
                            maxLines: 5 ,
                            controller: content,
                             decoration: InputDecoration(
                             border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: 'content'
                        ),
                        validator: (value) {
                          if(value?.isEmpty ?? true){
                          return 'please enter password';
                        }
                        },
                           ),
                           actions: [ElevatedButton(onPressed: () {
                             fire1();
                           }, child: Text('save'))],
                           );
                         },);
                        }, icon: Icon(Icons.edit)),
                        IconButton(onPressed: () {
                          
                        }, icon: Icon(Icons.delete,color: Colors.red,))
                        ]),
                    
                  ),
                ),
              ],
            ),
          ),
          
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
         showDialog(context: context, builder: (BuildContext context) {
           return AlertDialog(
           title: TextFormField(
            controller: name,
                       decoration: InputDecoration(
                       border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: 'name'
                  ),
                     ),
                     content: TextFormField(
                      maxLines: 5,
                      controller: content,
                       decoration: InputDecoration(
                       border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: 'content'
                  ),
                     ),
                     actions: [ElevatedButton(onPressed: () {
                       click();
                     }, child: Text('save'))],
           );
         },);
        },
        child: Text('click'),
        ),
      ),
    );
  }
}