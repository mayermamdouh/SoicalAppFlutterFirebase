import 'package:chat_app/Models/UsersModel.dart';
import 'package:chat_app/Screens/HomePages/HomeCubit.dart';
import 'package:chat_app/Screens/chats/ChatDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../HomePages/HomeSates.dart';

class chatsscreen extends StatelessWidget {
  const chatsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, SocialState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: CubitApp.get(context).Users.length > 0,
            builder: (BuildContext context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    BuildChatItem(CubitApp.get(context).Users[index], context),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                itemCount: CubitApp.get(context).Users.length),
            fallback: (BuildContext context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget BuildChatItem(SoicalUserModel user, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetails(
                      usermodel: user,
                    )),
          );
          CubitApp.get(context).GetMessages(receiveId: user.uId!);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('${user.Image}'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                '${user.name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      );
}
