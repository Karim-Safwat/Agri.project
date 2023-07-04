import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField(
    {
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator<String>? validator,
  required IconData prefix,
  required String label,
  Function()? onPressedSuffix,
  IconData? suffix,
  bool isPassword = false,
  bool isUpperCase = true,
  ValueChanged<String>? onFieldSubmitted,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  double? radius ,
} )
=> TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validator,
  obscureText: isPassword,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  onTap: onTap,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius!),
    ),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null? IconButton(
      onPressed: onPressedSuffix,
      icon: Icon(suffix),
    )
        : null,
    label: Text(
      label
     // isUpperCase ? label.toUpperCase() : label,
    ),
  ),
);


Widget buildTextButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  required Function() onPressedTextButton,
  required String text,
  bool isUpperCase = true,
})=> Container(
  width: width,
  decoration: BoxDecoration(
    color: background,
    borderRadius: BorderRadius.circular(radius),

  ),
  child: TextButton(
    onPressed: onPressedTextButton,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
);

Widget buildDefaultTextButton({
  required Function() onPressedTextButton,
  required String text,
  bool isUpperCase = true,
  // double width =double.infinity,
  // Color background=Colors.blue,
  // double radius=3.0,
})=>TextButton(

  onPressed: onPressedTextButton,

  child: Text(

    isUpperCase ? text.toUpperCase() : text,

    style: const TextStyle(

        fontSize: 20.0,

        fontWeight: FontWeight.bold,

        color: Colors.blue

    ),

  ),

);

void showToast ({
  required String text,
  required ToastState state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastState{success,error,warning}

Color chooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}



