import 'package:chat_app/Screens/EditProfile/EditProfile.dart';
import 'package:chat_app/Screens/HomePages/HomeCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Components.dart';
import '../HomePages/HomeSates.dart';

class settingScreen extends StatelessWidget {
  const settingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var UserData = CubitApp.get(context).Model;
    return BlocConsumer<CubitApp, SocialState>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
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
                            image: NetworkImage('${UserData!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                  CircleAvatar(
                    radius: 53,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage('${UserData!.Image}'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              '${UserData.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '${UserData.bio}',
              style: TextStyle(fontSize: 13),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Post',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Photos',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Follows',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                SizedBox(
                  width: 5,
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => editProfile()),
                      );
                    },
                    child: Icon(Icons.edit))
              ],
            )
          ],
        ),
      ),
    );
  }
}
