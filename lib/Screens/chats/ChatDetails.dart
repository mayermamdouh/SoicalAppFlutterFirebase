import 'package:chat_app/Models/MessageModel.dart';
import 'package:chat_app/Screens/HomePages/HomeCubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Models/UsersModel.dart';
import '../HomePages/HomeSates.dart';

class ChatDetails extends StatelessWidget {
  SoicalUserModel? usermodel;
  ChatDetails({this.usermodel});
  var TextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, SocialState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black87,
                  )),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${usermodel?.Image}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${usermodel?.name}',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            body: ConditionalBuilder(
                condition: CubitApp.get(context).messages.length > 0,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var message =
                                      CubitApp.get(context).messages[index];
                                  if (CubitApp.get(context).Model?.uId ==
                                      message.SnederId)
                                    return buildMyMeesageItem(message);
                                  return buildMessageItem(message);
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 15,
                                    ),
                                itemCount:
                                    CubitApp.get(context).messages.length),
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
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
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        final now = DateTime.now();
                                        String formattedDateTime =
                                            DateFormat('yyyy-MM-dd HH:mm')
                                                .format(now);
                                        CubitApp.get(context).SendMessage(
                                          receiveId: usermodel!.uId!,
                                          text: TextController.text,
                                          dataTime: formattedDateTime,
                                        );
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
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
          );
        },
        listener: (context, state) {});
  }

  Widget buildMessageItem(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text(
            '${model.Text}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );

  Widget buildMyMeesageItem(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 197, 235, 252),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text(
            '${model.Text}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
