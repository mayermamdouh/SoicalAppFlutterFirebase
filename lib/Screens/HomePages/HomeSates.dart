abstract class SocialState {}

class SoicalInitial extends SocialState {}

class SoicalGetUserLoading extends SocialState {}

class SoicalGetUserSuccess extends SocialState {}

class SoicalGetUserError extends SocialState {
  final String Error;
  SoicalGetUserError(this.Error);
}

class SoicalChangeNavBar extends SocialState {}

class SoicalAddPostNavBar extends SocialState {}

class GetProfileImageSuccess extends SocialState {}

class GetProfileImageError extends SocialState {}

class GetcoverImageSuccess extends SocialState {}

class GetcoverImageError extends SocialState {}

class UploadcoverImageSuccess extends SocialState {}

class UploadcoverImageError extends SocialState {}

class UploadProfileImageSuccess extends SocialState {}

class UploadProfileImageError extends SocialState {}

class UpdateUserDataLoading extends SocialState {}

class UpdateUserDataError extends SocialState {}

class UpdataPassVisabilityState extends SocialState {}

///Post Model
class CreatePostDataLoading extends SocialState {}

class CreatePostDataError extends SocialState {}

class CreatePostDataSuccess extends SocialState {}

class UploadPostImageLoading extends SocialState {}

class UploadPostImageError extends SocialState {}

class UploadPostImageSuccess extends SocialState {}

class GetPostImageSuccess extends SocialState {}

class GetPostImageError extends SocialState {}

class RemovePostImageSuccess extends SocialState {}

class GetPostsLoading extends SocialState {}

class GetPostsSuccess extends SocialState {}

class GetPostsError extends SocialState {}

///Likes
class MakeLikesSuccess extends SocialState {}

class MakeLikesError extends SocialState {}

class MakeLikesLoading extends SocialState {}

///Comment
class MakeCommentSuccess extends SocialState {}

class MakeCommentError extends SocialState {}

class MakeCommentLoading extends SocialState {}

//Get all users

class GetAllUserLoading extends SocialState {}

class GetAllUserSuccess extends SocialState {}

class GetAllUserError extends SocialState {
  final String Error;
  GetAllUserError(this.Error);
}

//Messages

class SendMessageSuccess extends SocialState {}

class SendMessageError extends SocialState {}

class GetMessageSuccess extends SocialState {}

class GetMessageError extends SocialState {}

//Get Comments

class GetCommentsSuccess extends SocialState {}

class GetCommentsLoading extends SocialState {}
