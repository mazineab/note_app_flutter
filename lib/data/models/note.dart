class Note{
  int? id,category_id;
  String? name,content;
  DateTime? createdAt,updatedAt;

  Note({this.id,this.category_id,this.name,this.content,this.createdAt,this.updatedAt});

  factory Note.fromJson(Map<String,dynamic> map){
    return Note(
      id: map['id'],
      category_id: map['category_id'],
      name: map['name'],
      content: map['content'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'category_id':category_id,
      'name':name,
      'content':content,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }


}