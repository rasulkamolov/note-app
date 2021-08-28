
import 'package:flutsql/screens/note_detail.dart';
import 'package:flutsql/screens/note_list.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(myApp()); 
}

class myApp extends StatelessWidget{

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'NoteKeeper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: NoteDetail(),
    );
  }
}