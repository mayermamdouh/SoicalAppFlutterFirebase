import 'package:chat_app/Screens/HomePages/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../CacheHelper.dart';
import '../Components.dart';
import '../RegisterPage/RegisterPage.dart';
import 'LoginCubit.dart';
import 'Loginstates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var FormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SoicalLoginCubit(),
      child: BlocConsumer<SoicalLoginCubit, SoicalLoginStates>(
        listener: (context, state) {
          if(state is SoicalLoginStatesErrorState){
            showToast(text:state.Error, states: ToastStates.ERROR);
          }
          if(state is SoicalLoginStatesSuccesState){

              showToast(text:'Login Success', states: ToastStates.SUCCESS);
              CacheHelper.saveData(key: 'uId', value: state.uId).
              then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen()),
                );
              }
              );
            }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            // appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Welcome \n Back  ',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButtom(
                          controller: emailcontroller,
                          icon: Icons.email,
                          lable: 'Email',
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Eamil must be not empty';
                            } else if (!value.contains("@")) {
                              return 'Must enter email please';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButtom(
                          isPassword:
                              SoicalLoginCubit.get(context).isPasswordShown,
                          suffix: SoicalLoginCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          // onChanged: (value){
                          //   // if (FormKey.currentState!.validate()) {
                          //   //   SoicalLoginCubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                          //   // }
                          // },

                          suffixpress: () {
                            SoicalLoginCubit.get(context).FunctionVisvility();
                          },

                          controller: passwordcontroller,
                          icon: Icons.lock,
                          lable: 'Password',
                          // onSum
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must be not empty\nplease enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: !(state is SoicalLoginStatesLoadingState),
                          builder: (context) => ButtonLogin(
                            function: () {
                              if (FormKey.currentState!.validate()) {
                                 SoicalLoginCubit.get(context).userLogin(email: emailcontroller.text, password: passwordcontroller.text);
                              }
                            },
                            width: double.infinity,
                            height: 35,
                            text: 'Login',
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an Account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPageSoicalpingApp()),
                                );
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
