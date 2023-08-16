import 'dart:io';

import 'package:chat_app/Screens/HomePages/HomeCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../Components.dart';
import '../HomePages/HomeSates.dart';

class editProfile extends StatelessWidget {
  const editProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var UserData = CubitApp.get(context).Model;

    var namecontroller = TextEditingController();
    var biocontroller = TextEditingController();

    var passcontroller = TextEditingController();
    var emailcontroller = TextEditingController();
    var phonecontroller = TextEditingController();

    var ProfileImage = CubitApp.get(context).ProfileImage;
    var CoverImage = CubitApp.get(context).CoverImage;

    namecontroller.text = UserData!.name ?? '';
    biocontroller.text = UserData.bio!;

    emailcontroller.text = UserData.email!;
    phonecontroller.text = UserData.phone!;

    return BlocConsumer<CubitApp, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black87,
                  )),
              title: Text(
                'Edit Your Profile',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      CubitApp.get(context).UploadCoverImage(
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                          bio: biocontroller.text);

                      CubitApp.get(context).UploadProfileImage(
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                          bio: biocontroller.text);

                      CubitApp.get(context).UpdateUserData(
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          phone: phonecontroller.text,
                          bio: biocontroller.text);
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ))
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoading) LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
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
                                    image: DecorationImage(
                                      image: CoverImage == null
                                          ? NetworkImage('${UserData.cover}')
                                          : FileImage(CoverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                  backgroundColor: Colors.lightBlue,
                                  child: IconButton(
                                      onPressed: () {
                                        CubitApp.get(context).getCoverImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_enhance_outlined,
                                        color: Colors.black87,
                                      ))),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: ProfileImage == null
                                    ? NetworkImage('${UserData.Image}')
                                    : FileImage(ProfileImage) as ImageProvider,
                              ),
                            ),
                            CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.lightBlue,
                                child: IconButton(
                                    onPressed: () {
                                      CubitApp.get(context).getProfileImage();
                                    },
                                    icon: Icon(
                                      Icons.camera_enhance_outlined,
                                      color: Colors.black87,
                                    ))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextButtom(
                      controller: namecontroller,
                      icon: Icons.person,
                      lable: 'Edit Your Name',
                      type: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must be not empty';
                        }
                      },
                    ),
                  ),
                  TextButtom(
                    controller: biocontroller,
                    icon: Icons.person,
                    lable: 'Edit Your Bio',
                    type: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bio must be not empty';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextButtom(
                      controller: emailcontroller,
                      icon: Icons.email,
                      lable: 'Edit Your Email ',
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Eamil must be not empty';
                        } else if (!value.contains("@")) {
                          return 'Must enter email right please';
                        }
                      },
                    ),
                  ),
                  TextButtom(
                    controller: phonecontroller,
                    icon: Icons.phone_android_outlined,
                    lable: 'Edit Your Phone ',
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Number must be not empty';
                      }
                      // Regular expression pattern for 11-digit phone number
                      final phoneRegex = r'^\d{11}$';
                      if (!RegExp(phoneRegex).hasMatch(value)) {
                        return 'Please enter a valid 11-digit phone number';
                      }
                    },
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
