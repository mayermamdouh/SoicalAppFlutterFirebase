
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Loginstates.dart';


class SoicalLoginCubit extends Cubit<SoicalLoginStates>
{
  SoicalLoginCubit(): super(IntialState());
  static SoicalLoginCubit get(context)=> BlocProvider.of(context);




  void userLogin({
    required String email,
    required String password,
  }){
    emit(SoicalLoginStatesLoadingState());
     FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
         .then((value)  {
           print('This login Method');
           print(value.user?.email);
           print(value.user?.uid);
           emit(SoicalLoginStatesSuccesState(value.user!.uid));
     })
         .catchError((error){
           emit(SoicalLoginStatesErrorState(error.toString()));
     });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShown = true;

  void FunctionVisvility(){
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPasswordShown = !isPasswordShown;
    emit(SoicalLoginPassVisabilityState());
  }
}



