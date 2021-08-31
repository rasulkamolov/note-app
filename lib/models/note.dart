class Note {
  late final int _id;
  late final String _title;
  late final String _description;
  late final String _date;
  late final int _priority;

  Note(this._title, this._date, this._priority, this._description);
  Note.withId(this._id, this._date, this._priority, this._description);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String newTitle){
    this._title = newTitle;
  }

  set description(String newDescription){
    this._description = newDescription;
  }
  set priority(int newPriority){
    this._priority = newPriority;
  }

  set date(String newDate){
    this._date = newDate;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    
    if(id!=null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  } 
}

