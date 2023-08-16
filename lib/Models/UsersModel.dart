class SoicalUserModel{
  String? name;
  String? email;
  String? phone;
  String? password;
  String? uId;
  bool? EmailVerified;
  String? Image;
  String? cover;
  String? bio;

  SoicalUserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.uId,
    this.EmailVerified,
    this.Image,
    this.cover,
    this.bio
});

  SoicalUserModel.fromJson(Map<String,dynamic>? json){
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    password = json?['password'];
    uId = json?['uId'];
    Image = json?['Image'];
    cover = json?['cover'];
    bio = json?['bio'];
    EmailVerified = json?['EmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
      'uId':uId,
      'Image':Image,
      'cover':cover,
      'bio':bio,
      'EmailVerified':EmailVerified,

    };
}
}