import 'package:flutsql/models/note.dart';
import 'package:flutsql/screens/note_detail.dart';
import 'package:flutsql/utils/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    
    return NoteListState();
  }
}

class NoteListState extends State<NoteList>{
  
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;
  int count = 0;


  @override 
  Widget build(BuildContext context){
    if(noteList == null){
      noteList = <Note>[];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('SuperNote'),
        centerTitle: true,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          debugPrint('FAB clicked');
          NavigateToDetail(Note('','',2,''),"Add Note");
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
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: (){
                _delete(context, noteList[position]);
              },
            ),
            onTap: (){
              debugPrint("ListTile tapped");
              NavigateToDetail(this.noteList[position],"Edit Note");
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, Note note)async{
    int result = await databaseHelper.deleteNote(note.id);
    if(result != 0){
      _showSnackbar(context, 'Note was deleted!');
       updateListView();
    }
  }
  
  void _showSnackbar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger(child: snackBar);
  }

  void NavigateToDetail(Note note, String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
            return NoteDetail(note, title);
          }));
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initiateDatabase();
		dbFuture.then((database) {

			Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
			noteListFuture.then((noteList) {
				setState(() {
				  this.noteList = noteList;
				  this.count = noteList.length;
				});
			});
		});
  }

}