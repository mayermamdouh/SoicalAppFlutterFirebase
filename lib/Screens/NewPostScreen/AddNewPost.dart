import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Components.dart';
import '../HomePages/HomeCubit.dart';
import '../HomePages/HomeSates.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    var UserData = CubitApp.get(context).Model;

    return BlocConsumer<CubitApp, SocialState>(
      listener: (context, State) {
        if (State is CreatePostDataSuccess) {
          CubitApp.get(context).textController.text = '';
          // CubitApp.get(context).PostImage = null;
        }
      },
      builder: (context, State) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    CubitApp.get(context).textController.text = '';
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black87,
                  )),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Add New Post',
                style: TextStyle(color: Colors.black),
              )),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 53,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('${UserData!.Image}'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${UserData.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: CubitApp.get(context).textController,
                              maxLines: null,
                              onChanged: (text) {
                                CubitApp.get(context).enteredText =
                                    text; // Store the entered text
                              },
                              decoration: InputDecoration(
                                hintText: 'Write is on Your Mind...',
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (CubitApp.get(context).PostImage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                                image: CubitApp.get(context).PostImage != null
                                    ? DecorationImage(
                                        image: FileImage(
                                            CubitApp.get(context).PostImage!),
                                        fit: BoxFit.fill,
                                      )
                                    : null, // No image decoration if PostImage is null
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircleAvatar(
                                backgroundColor: Colors.lightBlue,
                                child: IconButton(
                                    onPressed: () {
                                      CubitApp.get(context).RemovePostImage();
                                    },
                                    icon: Icon(
                                      Icons.cancel_sharp,
                                      color: Colors.black87,
                                    ))),
                          ),
                        ],
                      ),
                    ),
                  TextButton(
                      onPressed: () {
                        final now = DateTime.now();
                        String formattedDateTime =
                            DateFormat('yyyy-MM-dd HH:mm').format(now);
                        CubitApp.get(context).UploadPostImage(
                            text: CubitApp.get(context).textController.text,
                            dataTime: formattedDateTime);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.post_add_sharp),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Post'),
                        ],
                      )),
                  if (State is CreatePostDataLoading ||
                      State is UploadPostImageSuccess)
                    LinearProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                CubitApp.get(context).getPostImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo_sharp),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Add Photo'),
                                ],
                              )),
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.tag_sharp),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Tags'),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
