import 'package:chat_app/Models/CommetsModel.dart';
import 'package:chat_app/Screens/HomePages/HomeCubit.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Components.dart';
import '../../Models/PostModel.dart';
import '../HomePages/HomeSates.dart';

class feedsScreen extends StatelessWidget {
  var TextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final TextEditingController commentController = TextEditingController();
    // GlobalKey commentBoxKey = GlobalKey();
    return BlocConsumer<CubitApp, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CubitApp.get(context).Posts.length > 0,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/charming-positive-dark-skinned-friendly-woman-enjoys-informal-meeting-online-waves-palm-says-hi-smartphone-uses-video-messanger-takes-selfie-wears-stylish-grey-jacket-greets-friend_273609-43223.jpg'),
                        fit: BoxFit.cover,
                        height: 170,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Communcation With Friends',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => BuildPostItem(
                      CubitApp.get(context).Posts[index], context, index),
                  itemCount: CubitApp.get(context).Posts.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 4,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          fallback: (BuildContext context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget BuildPostItem(PostUserModel model, context, index) => Card(
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${model.Image}'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 14,
                                )
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '${model.DataTime}',
                          style: TextStyle(color: Colors.black45, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.80,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 13, bottom: 5, right: 5),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1,
                          height: 23,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#Software_Engineering',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.PostImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage('${model.Image}'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CubitApp.get(context).LikesNum[index!] > 0
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.black,
                                  ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('${CubitApp.get(context).LikesNum[index!]}'),
                          ],
                        ),
                        onTap: () {
                          CubitApp.get(context)
                              .PostsLike(CubitApp.get(context).PostId[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chat_bubble_outline_sharp),
                            SizedBox(
                              width: 8,
                            ),
                            Text(CubitApp.get(context).CommentsNum.isNotEmpty
                                ? '${CubitApp.get(context).CommentsNum[index ?? 0]}'
                                : 'No Comments')
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            // color is applied to main screen when modal bottom screen is displayed
                            // barrierColor: Colors.greenAccent,
                            //background color for modal bottom screen
                            backgroundColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            //elevates modal bottom screen
                            elevation: 10,
                            // gives rounded corner to modal bottom screen
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            builder: (BuildContext context) {
                              // UDE : SizedBox instead of Container for whitespaces
                              return BuildBottomSheet(context, index);
                            },
                          );
                          CubitApp.get(context).GetComments(
                              MakeComUid: CubitApp.get(context).Model?.uId,
                              postUid: CubitApp.get(context)
                                  .PostId
                                  .elementAt(index));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                '${CubitApp.get(context).Model?.Image}'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Write a comment...',
                          ),
                          SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Like'),
                      ],
                    ),
                    onTap: () {
                      // CubitApp.get(context).PostsLike(CubitApp.get(context).Likes[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget BuildBottomSheet(context, index) => SizedBox.expand(
        // height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => BuildCommentItem(
                          CubitApp.get(context).Comments[index], context),
                      separatorBuilder: (context, inxde) => SizedBox(
                            height: 10,
                          ),
                      itemCount: CubitApp.get(context).Comments.length),
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: TextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'type your message...',
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 70,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30)),
                          child: MaterialButton(
                            onPressed: () {
                              final now = DateTime.now();
                              // String formattedDateTime =
                              //     DateFormat('yyyy-MM-dd HH:mm').format(now);
                              CubitApp.get(context).PostsComment(
                                  CubitApp.get(context).PostId[index],
                                  TextController.text,
                                  CubitApp.get(context).Model?.Image);
                              TextController.text = '';
                            },
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget BuildCommentItem(CommentsModel model, context) => Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('${model.MakeCommentImage}'),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${model.commentText}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      );
}
