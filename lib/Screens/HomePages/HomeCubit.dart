import 'dart:io';
import 'package:chat_app/Models/MessageModel.dart';
import 'package:chat_app/Models/UsersModel.dart';
import 'package:chat_app/Screens/Feeds/FeedsScreen.dart';
import 'package:chat_app/Screens/chats/chatsScreen.dart';
import 'package:chat_app/Screens/setting/settingScreen.dart';
import 'package:chat_app/Screens/users/UsersScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../Components.dart';
import '../../Models/CommetsModel.dart';
import '../../Models/PostModel.dart';
import '../NewPostScreen/AddNewPost.dart';
import 'HomeSates.dart';

class CubitApp extends Cubit<SocialState> {
  CubitApp() : super(SoicalInitial());

  static CubitApp get(context) => BlocProvider.of(context);

  List<String> title = [
    'Home',
    'Chat',
    'Add Post',
    'Users',
    'Setting',
  ];

  int currentindex = 0;
  List<Widget> screens = [
    feedsScreen(),
    chatsscreen(),
    NewPost(),
    usersScreen(),
    settingScreen(),
  ];

  void ChangeNavBar(int index) {
    if (index == 2) {
      emit(SoicalAddPostNavBar());
    } else if (index == 1) {
      GetAllUsers();
      currentindex = index;
      emit(SoicalChangeNavBar());
    } else {
      currentindex = index;
      emit(SoicalChangeNavBar());
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void FunctionVisvility() {
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    isPasswordShown = !isPasswordShown;
    emit(UpdataPassVisabilityState());
  }

  SoicalUserModel? Model;

  void GetUserData() {
    emit(SoicalGetUserLoading());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      print('This Function Get User Data From Database Firebase');
      Model = SoicalUserModel.fromJson(value.data());
      print(Model?.Image);
      print(Model?.cover);
      emit(SoicalGetUserSuccess());
    }).catchError((error) {
      emit(SoicalGetUserError(error.toString()));
    });
  }

  File? ProfileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      ProfileImage = File(PickedFile.path);
      emit(GetProfileImageSuccess());
    } else {
      print('No image Selected');
      emit(GetProfileImageError());
    }
  }

  File? CoverImage;
  final picker2 = ImagePicker();

  Future getCoverImage() async {
    final PickedFile = await picker2.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      CoverImage = File(PickedFile.path);
      emit(GetcoverImageSuccess());
    } else {
      print('No image Selected');
      emit(GetcoverImageError());
    }
  }

  // void UploadProfileImage({
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String bio,
  // }) {
  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('Users/${Uri.file(ProfileImage!.path).pathSegments.last}')
  //       . //b save alsora b 25er goz2 f 2sm alsora 3la al firebase storage
  //       putFile(ProfileImage!)
  //       .then((value) => {
  //             value.ref.getDownloadURL().then((value) {
  //               emit(UploadProfileImageSuccess());
  //               print(value);
  //               UpdateUserData(
  //                   bio: bio,
  //                   email: email,
  //                   name: name,
  //                   phone: phone,
  //                   Image: value);
  //             }).catchError((error) {
  //               emit(UploadProfileImageError());
  //             })
  //           })
  //       .catchError((error) {
  //     emit(UploadProfileImageError());
  //     print(error.toString());
  //   }); // ya3ne 7ot alsora aw 2rf3a alsora
  // }
  void UploadProfileImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
  }) {
    if (ProfileImage == null) {
      emit(UploadProfileImageError());
      print('No profile image to upload');
      return;
    }

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadProfileImageSuccess());
        print(value);
        UpdateUserData(
          bio: bio,
          email: email,
          name: name,
          phone: phone,
          Image: value,
        );
        UpdatePostData(Image: value, name: name);
        emit(UpdatePostImage());
      }).catchError((error) {
        emit(UploadProfileImageError());
      });
    }).catchError((error) {
      emit(UploadProfileImageError());
      print(error.toString());
    });
  }

  void UploadCoverImage({
    required String name,
    required String email,
    required String phone,
    required String bio,
  }) {
    if (CoverImage == null) {
      emit(UploadcoverImageError());
      print('No cover image to upload');
      return;
    }

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadcoverImageSuccess());
        print(value);
        UpdateUserData(
          bio: bio,
          email: email,
          name: name,
          phone: phone,
          cover: value,
        );
        // UpdatePostData(Image: value);
        // emit(UpdatePostImage());
      }).catchError((error) {
        emit(UploadcoverImageError());
      });
    }).catchError((error) {
      emit(UploadcoverImageError());
      print(error.toString());
    });
  }

  void UpdateUserData(
      {required String name,
      required String email,
      required String phone,
      required String bio,
      String? cover,
      String? Image}) {
    emit(UpdateUserDataLoading());

    SoicalUserModel modelUser = SoicalUserModel(
      name: name,
      email: email,
      phone: phone,
      cover: cover ?? Model?.cover,
      Image: Image ?? Model?.Image,
      uId: Model?.uId,
      bio: bio,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(Model?.uId)
        .update(modelUser.toMap())
        .then((value) {
      // UpdatePostData(
      //   name: name,
      // );
      GetUserData();
    }).catchError((error) {
      emit(UpdateUserDataError());
    });
  }

  File? PostImage;
  final picker3 = ImagePicker();

  String enteredText = '';
  final TextEditingController textController = TextEditingController();
  Future getPostImage() async {
    final PickedFile = await picker3.pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      PostImage = File(PickedFile.path);
      emit(GetPostImageSuccess());
      textController.text =
          enteredText; // Set the stored text back to the TextFormField
    } else {
      print('No image Selected');
      emit(GetPostImageError());
    }
  }

  // String currentText = '';
  // void TextNotCleaning(newValue) {
  //   currentText = newValue;
  // }

  void RemovePostImage() {
    PostImage = null;
    emit(
        RemovePostImageSuccess()); // Emit a state indicating that the image has been removed
  }

  void UploadPostImage({
    required String text,
    required String dataTime,
  }) {
    if (PostImage == null) {
      emit(UploadPostImageError());
      CreateNewPost(text: text, dataTime: dataTime);
      print('No post image to upload');
      return;
    }

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadPostImageSuccess());
        print(value);
        CreateNewPost(text: text, dataTime: dataTime, PostImage: value);
      }).catchError((error) {
        emit(UploadPostImageError());
      });
    }).catchError((error) {
      emit(UploadPostImageError());
      print(error.toString());
    });
  }

  void CreateNewPost(
      {required String text, required String dataTime, String? PostImage}) {
    emit(CreatePostDataLoading());

    PostUserModel modelUser = PostUserModel(
      name: Model?.name,
      text: text,
      uId: Model?.uId,
      Image: Model?.Image,
      DataTime: dataTime,
      PostImage: PostImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('Posts')
        .add(modelUser.toMap()) //add de hy create new Uid l kol post auyomatc
        .then((value) {
      emit(CreatePostDataSuccess());
    }).catchError((error) {
      emit(CreatePostDataError());
    });
  }

// bst5dm get() de htgeb kolo lkn .doc da ya3ne post wa7d bs alhyge 3la 7asb al uId
  List<PostUserModel> Posts = [];
  List<String> PostId = [];
  List<int> LikesNum = [];
  List<int> CommentsNum = [];
  void GetPosts() {
    emit(GetPostsLoading());
    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('DataTime')
        .snapshots()
        .listen((postsSnapshot) {
      Posts = [];
      LikesNum = []; // Initialize LikesNum here
      PostId = [];
      CommentsNum = [];

      postsSnapshot.docs.forEach((postDoc) {
        PostUserModel post = PostUserModel.fromJson(postDoc.data());
        Posts.add(post);
        PostId.add(postDoc.id);
        LikesNum.add(0);
        CommentsNum.add(0);
        // Initialize like count with 0
        print('/////////////////////////////////');
        print(Posts[0].PostImage);
        postDoc.reference
            .collection('Likes')
            .snapshots()
            .listen((likesSnapshot) {
          LikesNum[PostId.indexOf(postDoc.id)] = likesSnapshot.docs.length;
        });

        postDoc.reference
            .collection('Comments')
            .snapshots()
            .listen((likesSnapshot) {
          CommentsNum[PostId.indexOf(postDoc.id)] = likesSnapshot.docs.length;
        });
        emit(GetPostsSuccess());
      });
    });
  }

  void PostsLike(String PostUid) async {
    emit(MakeLikesLoading());
    DocumentReference likeRef = FirebaseFirestore.instance
        .collection('Posts')
        .doc(PostUid)
        .collection('Likes')
        .doc(Model?.uId);

    DocumentSnapshot likeSnapshot = await likeRef.get();
    //if post already like remove it
    if (likeSnapshot.exists) {
      likeRef.delete().then((_) {
        emit(MakeLikesSuccess());
      }).catchError((error) {
        emit(MakeLikesError());
      }); //else make like to post
    } else {
      likeRef.set({'Like': true}).then((value) {
        emit(MakeLikesSuccess());
      }).catchError((error) {
        emit(MakeLikesError());
      });
    }
  }

//Make Comment

  List<SoicalUserModel> Users = [];
  void GetAllUsers() {
    Users = []; // not repeat data when every call function
    emit(GetAllUserLoading());
    // bst5dm get() de htgeb kolo lkn .doc da ya3ne post wa7d bs alhyge 3la 7asb al uId
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] !=
            Model?.uId) // not get me when show all users
          Users.add(SoicalUserModel.fromJson(element.data()));
        emit(GetAllUserSuccess());
      });
    }).catchError((error) {
      emit(GetAllUserError(error.toString()));
    });
  }

  void SendMessage({
    //required String SendId, //Model.uId
    required String receiveId,
    required String text,
    required String dataTime,
  }) {
    MessageModel model = MessageModel(
      SnederId: Model?.uId,
      ReceiverId: receiveId,
      Text: text,
      DataTime: dataTime,
    );
    //my chats
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Model?.uId)
        .collection('Chats')
        .doc(receiveId)
        .collection('Messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((errer) {
      emit(SendMessageError());
    });
    // received chat
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiveId)
        .collection('Chats')
        .doc(Model?.uId)
        .collection('Messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((errer) {
      emit(SendMessageError());
    });
  }

  List<MessageModel> messages = [];

  void GetMessages({
    required String receiveId,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Model?.uId)
        .collection('Chats')
        .doc(receiveId)
        .collection('Messages')
        .orderBy('DataTime')
        .snapshots() //snapshots and listen da kda realtime ya3ne kobre 48al 3la tol ygeb data mn al firebase
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccess());
    });
  }

  void PostsComment(
      String PostUid, String text, String? MakeCommentImage) async {
    emit(MakeCommentLoading());

    CommentsModel model =
        CommentsModel(commentText: text, MakeCommentImage: MakeCommentImage);

    CollectionReference commentsCollection = FirebaseFirestore.instance
        .collection('Posts')
        .doc(PostUid)
        .collection('Comments');

    commentsCollection.add(model.toMap()).then((newCommentDoc) {
      // Get the newly added comment's document ID
      String commentDocId = newCommentDoc.id;

      // Update the comment with the 'Comment' field
      newCommentDoc.update({'Comment': text}).then((_) {
        emit(MakeCommentSuccess());
      }).catchError((error) {
        emit(MakeLikesError());
      });
    }).catchError((error) {
      emit(MakeLikesError());
    });
  }

  List<CommentsModel> Comments = [];

  void GetComments({String? postUid, String? MakeComUid}) {
    emit(GetCommentsLoading());

    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postUid)
        .collection('Comments')
        .snapshots()
        .listen((commentsSnapshot) {
      Comments = [];
      commentsSnapshot.docs.forEach((element) {
        Comments.add(CommentsModel.fromJson(element.data()));
      });
      emit(GetCommentsSuccess());
      print(Comments);
    });
  }

  void UpdatePostData({String? name, String? Image}) {
    FirebaseFirestore.instance
        .collection('Posts')
        .where('uId', isEqualTo: Model?.uId)
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        // Update each post's name and image
        doc.reference.update({
          'name': name,
          'Image': Image,
        });
      });
    });
  }
}
