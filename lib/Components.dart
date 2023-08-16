import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool visible = true;

Widget TextButtom({
  required TextEditingController controller,
  TextInputType? type,
  required String lable,
  IconData? icon,
  required String? Function(String?)? validator,
  IconData? suffix,
  bool isPassword = false,
  void Function()? suffixpress,
  ValueChanged<String>? onChanged,

  // Function() onSubmit,
}) =>
    TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: isPassword,
      keyboardType: type, //  no3 alhktbo gawa ya3ne number aw text....
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          icon,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixpress,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget ButtonLogin({
  required double width,
  Color background = Colors.lightBlue,
  bool isUpperCase = true,
  required double height,
  void Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text.toLowerCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? ChooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

var uId;

AppBar buildAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
}) {
  return AppBar(
    // leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new,color: Colors.black87,)),
    title: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    centerTitle: true,
    titleSpacing: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
    ),
    elevation: 0.0,
    backgroundColor: Colors.white,
    actions: actions,
  );
}
