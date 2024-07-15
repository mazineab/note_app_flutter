import 'package:intl/intl.dart';

class Note{
  int? id,category_id;
  String? name,content;
  DateTime? created_at,updated_at;
  String? nameCategory;

  Note({this.id,this.category_id,this.name,this.content,this.nameCategory,this.created_at,this.updated_at});

  factory Note.fromJson(Map<String,dynamic> map){
    return Note(
      id: map['id'],
      category_id: map['category_id'],
      name: map['name'],
      content: map['content'],
      created_at: map['created_at']!=null?DateTime.parse(map['created_at']):null,
      updated_at: map['updated_at']!=null?DateTime.parse(map['updated_at']):null
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'category_id':category_id,
      'name':name,
      'content':content,
      'created_at':created_at,
      'updated_at':updated_at
    };
  }

  parseTime(){
    final DateFormat formatter=DateFormat("dd/MM/yyyy");
    return formatter.format(created_at!);
  }


}