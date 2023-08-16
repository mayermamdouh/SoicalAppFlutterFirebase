class CommentsModel {
   String? MakeCommentImage;
   String? commentText;

  CommentsModel({
     this.MakeCommentImage,
     this.commentText,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      MakeCommentImage: json['MakeCommentImage'],
      commentText: json['commentText'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'MakeCommentImage': MakeCommentImage,
      'commentText': commentText,
    };
  }
}
