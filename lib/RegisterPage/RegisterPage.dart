import 'package:chat_app/Components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../CacheHelper.dart';
import '../Screens/HomePages/HomeScreen.dart';
import 'CubitRegister.dart';
import 'SatesRegister.dart';

class RegisterPageSoicalpingApp extends StatelessWidget {
  const RegisterPageSoicalpingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();
    var namecontroller = TextEditingController();
    var phonecontroller = TextEditingController();
    var FormKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SoicalRegisterCubit(),
      child: BlocConsumer<SoicalRegisterCubit, SoicalRedisterStates>(
        listener: (BuildContext context, Object? state) {
          if (state is SoicalCreateUserStatesSuccesState) {
            // CacheHelper.saveData(key: 'uId', value: state.id).
            // then((value) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => HomeScreen()),
            //   );
            // }
            // );
            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()),
                );


          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: buildAppBar(title: 'Register', context: context),
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
                          'Register',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButtom(
                          controller: namecontroller,
                          icon: Icons.person,
                          lable: 'Name',
                          type: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must be not empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButtom(
                          controller: emailcontroller,
                          icon: Icons.email,
                          lable: 'Email Address',
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
                          controller: phonecontroller,
                          icon: Icons.phone_android_outlined,
                          lable: 'Phone Number',
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
                        SizedBox(
                          height: 15,
                        ),
                        TextButtom(
                          isPassword:
                              SoicalRegisterCubit.get(context).isPasswordShown,
                          suffix: SoicalRegisterCubit.get(context).suffix,
                          type: TextInputType.visiblePassword,
                          suffixpress: () {
                            SoicalRegisterCubit.get(context)
                                .FunctionVisvility();
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
                          condition: state is! SoicalRegisterStatesLoadingState,
                          builder: (BuildContext context) => ButtonLogin(
                            function: () {
                              if (FormKey.currentState!.validate()) {
                                SoicalRegisterCubit.get(context).userRegister(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text,
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                );
                              }
                            },
                            width: double.infinity,
                            height: 35,
                            text: 'Register',
                          ),
                          fallback: (BuildContext context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
