class User{
  int? id;
  String? name,email,phoneNumber,password;
  DateTime? createdAt,updatedAt;

  User({this.id,this.name,this.email,this.phoneNumber,this.password,this.createdAt,this.updatedAt});

  factory User.fromJson(Map<String,dynamic> map){
    return User(
        id:map['id'],
        name:map['name'],
        email:map['email'],
        phoneNumber:map['phoneNumber'],
        password:map['password'],
        createdAt:map['createdAt'],
        updatedAt:map['updatedAt']
    );
  }

  Map<String,dynamic >toJson(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'phoneNumber':phoneNumber,
      'password':password,
      'createdAt':createdAt,
      'updatedAt':updatedAt
    };
  }

  @override
  String toString() {
    return "$name $email $phoneNumber $password";
  }
}