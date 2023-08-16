class PostUserModel{
  String? name;
  String? text;
  String? uId;
  String? Image;
  String? PostImage;
  String? DataTime;
  

  PostUserModel({
    this.name,
    this.text,
    this.uId,
    this.Image,
    this.PostImage,
    this.DataTime,

});

  PostUserModel.fromJson(Map<String,dynamic>? json){
    name = json?['name'];
    text = json?['text'];
    uId = json?['uId'];
    Image = json?['Image'];
    PostImage = json?['PostImage'];
    DataTime = json?['DataTime'];

  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'text':text,
      'uId':uId,
      'Image':Image,
      'PostImage':PostImage,
      'DataTime':DataTime,

    };
}
}