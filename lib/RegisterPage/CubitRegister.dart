import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/UsersModel.dart';
import 'SatesRegister.dart';

class SoicalRegisterCubit extends Cubit<SoicalRedisterStates> {
  SoicalRegisterCubit() : super(SoicalRegisterStatesIntialState());

  static SoicalRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,

  }){
    emit(SoicalRegisterStatesLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      CreateUser(name: name, email: email, phone: phone, password: password, uId: value.user!.uid,
      );

    }).catchError((error) {
      print(error.toString());
      emit(SoicalRegisterStatesErrorState(error.toString()));
    });
  }

  void CreateUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uId,

    
}){

    SoicalUserModel modelUser = SoicalUserModel(
      uId :uId,
      name: name,
      email : email,
      password : password,
      phone : phone,
      cover : 'https://media.istockphoto.com/id/1216824023/photo/confused-young-man-working-at-home.jpg?s=612x612&w=0&k=20&c=lk9F44ylaicq4eGuDCpa-RsfQaYiLJ87e7LZhgVI32Y=',
      Image : 'https://media.istockphoto.com/id/1216824023/photo/confused-young-man-working-at-home.jpg?s=612x612&w=0&k=20&c=lk9F44ylaicq4eGuDCpa-RsfQaYiLJ87e7LZhgVI32Y=',
      bio:'Write Your bio',
      EmailVerified: false,
    );
  FirebaseFirestore.instance.collection('Users').doc(uId).set(modelUser.toMap())
      .then((value) {
    emit(SoicalCreateUserStatesSuccesState(uId));
  }).catchError((error){
    print(error.toString());
    emit(SoicalCreateUserStatesErrorState(error.toString()));
  });
}






  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void FunctionVisvility() {
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    isPasswordShown = !isPasswordShown;
    emit(SoicalRegisterPassVisabilityState());
  }
}
