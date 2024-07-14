class Category{
  int? id,user_id;
  String? nameCategory;
  DateTime? createdAt,updatedAt;

  Category({this.id,this.user_id,this.nameCategory,this.createdAt,this.updatedAt});

  factory Category.fromJson(Map<String,dynamic> map){
    return Category(
      id:map['id'],
      user_id:map['user_id'],
      nameCategory:map['nameCategory'],
      createdAt:map['createdAt'],
      updatedAt:map['updatedAt']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'user_id':user_id,
      'nameCategory':nameCategory,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

}