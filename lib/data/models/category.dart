class Category{
  int? id,user_id;
  String? nameCat;
  DateTime? createdAt,updatedAt;

  Category({this.id,this.user_id,this.nameCat,this.createdAt,this.updatedAt});

  factory Category.fromJson(Map<String,dynamic> map){
    return Category(
      id:map['id'],
      user_id:map['user_id'],
        nameCat:map['nameCat'],
      createdAt:map['createdAt'],
      updatedAt:map['updatedAt']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'user_id':user_id,
      'nameCat':nameCat,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

}