import 'package:flutsql/models/note.dart';
import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
const NoteDetail(this.note,this.appBarTitle) : super();
  final String appBarTitle;
  final Note note;

  @override
  _NoteDetailState createState() {
    return _NoteDetailState(this.note,this.appBarTitle);
  } 
}

class _NoteDetailState extends State<NoteDetail> {
  Note note;
  String appBarTitle;
  static var _priorities = ['High', 'Low'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  _NoteDetailState(this.note, this.appBarTitle);
  bool isTrue = true;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return WillPopScope(
      onWillPop: _onWillPop,
     child: Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
          
          ), 
          onPressed: () {
            moveToLastScreen();
            },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorities.map((String dropDownStringItem){
                  return DropdownMenuItem<String>
                  (
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                style: textStyle,
                value: 'Low',
                onChanged: (valueSelectedByUser){
                  setState(() {
                    debugPrint('User selected $valueSelectedByUser'); 
                  });
                },
              ),
            ),
            // 2nd element
            Padding(
            padding:EdgeInsets.only(top: 15.0,bottom: 15.0),
            child: TextField(
              controller: titleController,
              style: textStyle,
              onChanged: (vale){
                debugPrint('Something changed');          
              },
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
            ),
            Padding(
            padding:EdgeInsets.only(top: 15.0,bottom: 15.0),
            child: TextField(
              controller: descController,
              style: textStyle,
              onChanged: (vale){
                debugPrint('Something changed');          
              },
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          debugPrint("Save button clicked");
                        });
                      },
                       child: Text('Save')
                       ),
                       ),
                       SizedBox(width: 5.0,),

                       Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          debugPrint("Delete button clicked");
                        });
                      },
                       child: Text('Delete')
                       ),
                       ),
                ],
              ),
              )


          ],
        ),
        ),

    )
    );
  }
void moveToLastScreen() {
  Navigator.pop(context);
}
Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(),
    )) ?? false;
  }
}




