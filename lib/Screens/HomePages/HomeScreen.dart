
import 'package:chat_app/Screens/NewPostScreen/AddNewPost.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components.dart';
import 'HomeCubit.dart';
import 'HomeSates.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, SocialState>
      (
      listener:(context,state){
        if(state is SoicalAddPostNavBar){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  NewPost()),
          );
        }
      },
      builder:(context,state){
        var cubit = CubitApp.get(context);
        return Scaffold(
          appBar:buildAppBar(title: '${cubit.title[cubit.currentindex]}',
          actions: [
            IconButton(onPressed: (){}, icon:Icon(Icons.notifications_none_sharp,color: Colors.black87,)),
            IconButton(onPressed: (){}, icon:Icon(Icons.search,color: Colors.black87,))
          ], context: context,
          ) ,
            body:cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.black87,
            selectedItemColor: Colors.lightBlue, // Set the selected item color to light blue
            backgroundColor: Colors.white,
            onTap: (index) {
              cubit.ChangeNavBar(index);
            },
            currentIndex: cubit.currentindex, // de bta3t update alColors lma 25trha tb2a lightblue
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(Icons.upload_file_outlined), label: 'Add Post'),
              BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_sharp), label: 'Users'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
            ],
          ),

        );
      },
    );
  }
}
// const Padding(
// padding: EdgeInsets.all(8.0),
// child: Column(
// children: [
// // ConditionalBuilder(
// //     condition:CubitApp.get(context).Model != null,
// //     builder:(context){
// //       var model = CubitApp.get(context).Model;
// //       return Column(
// //         children: [
// //           if(!FirebaseAuth.instance.currentUser!.emailVerified)
// //             Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.black,
// //                 borderRadius: BorderRadius.circular(20),
// //               ),
// //               child: Padding(
// //                 padding:  EdgeInsets.all(8.0),
// //                 child: Row(
// //
// //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                   children: [
// //                     Icon(Icons.info_outline,color: Colors.lightBlue,),
// //                     Text('Please Verify Your Email',style:
// //                     TextStyle(
// //                       color: Colors.lightBlue,
// //                       fontWeight: FontWeight.bold,
// //                     ),),
// //                     SizedBox(width: 20,),
// //                     TextButton(
// //                       onPressed: () {
// //                         FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
// //                           showToast(text:"Check Your Email", states: ToastStates.SUCCESS);
// //                         }).catchError((error){
// //                           print(error.toString());
// //                         });
// //                       },
// //                       child: Text(
// //                         'Send',
// //                         style: TextStyle(
// //                           color: Colors.lightBlue,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //         ],
// //       );
// //     },
// //     fallback:(context) => Center(child: CircularProgressIndicator(),) ,
// // ),
//
// ],
// ),
// ),