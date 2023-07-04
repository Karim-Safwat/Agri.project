import 'package:final_agriculture_project/modules/login/Login_Screen.dart';
import 'package:final_agriculture_project/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

void signOut(context)
{
  CacheHelper.signOut(key: 'token').then((value)
  {
    if(value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),),
              (route) => false);
    }
  });
}

String? token = '';
String? uid = '';

// دي بتاع ال ميل verification

// if(model!.isEmailVerified==false)
//            Container(
//              color: Colors.amber.withOpacity(0.6),
//              child: Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                child: Row(
//                  children: [
//                    Icon(Icons.info_outline),
//                    SizedBox(width: 20.0,),
//                    Expanded(
//                        child:
//                        Text('please verify your e-mail')),
//                    SizedBox(width: 20.0,),
//                    buildDefaultTextButton(
//                      onPressedTextButton: (){
//                        FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
//                          showToast(text: 'check your mail',
//                          state: ToastState.success
//                          );
//                        }).catchError((error){
//
//                        });
//                      },
//                      text: 'Send',
//                      isUpperCase: true,
//                    ),
//                  ],
//                ),
//              ),
//            ),