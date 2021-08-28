import 'package:flutter/material.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail() : super();

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  static var _priorities = ['High', 'Low'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
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

    );
  }
}