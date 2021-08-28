import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NoteList extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    
    return NoteListState();
  }
}

class NoteListState extends State<NoteList>{
  
  int count =0;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperNote'),
        centerTitle: true,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB clicked');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );  
  }
  ListView getNoteListView(){
    
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text('DummyText'),
            subtitle: Text("DummyDate"),

            onTap: (){
              debugPrint("ListTile tapped");
            },
          ),
        );
      },
    );
  }
}