import 'package:final_agriculture_project/components/components.dart';
import 'package:final_agriculture_project/components/constants.dart';
import 'package:final_agriculture_project/layout/home_screen.dart';
import 'package:final_agriculture_project/models/user_model.dart';
import 'package:final_agriculture_project/modules/register/cubit/cubit.dart';

import 'package:final_agriculture_project/modules/register/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';


var nameController = TextEditingController();
var phoneController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
//var imageController = TextEditingController();
var formKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectRegisterCubit(),
      child: BlocConsumer< ProjectRegisterCubit, ProjectRegisterStates>(
        listener: (context, state)
        {
          if(state is ProjectCreateUserSuccessState)
          {
            Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) =>LayoutScreen()),
                  (Route<dynamic>route)=>false,
            );
            }

        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              // appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SIGN IN',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 15,),
                          Text(
                            'create your account now and manage your agriculture fields...',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Name';
                              }
                              return null;
                            },
                            prefix: Icons.person_outline_outlined,
                            label: 'name',
                            radius: 15.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Phone';
                              }
                              return null;
                            },
                            prefix: Icons.phone_android_outlined,
                            label: 'phone',
                            radius: 15.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your email';
                              }
                              return null;
                            },
                            prefix: Icons.email_outlined,
                            label: 'email address',
                            radius: 15.0,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Password';
                              }
                              return null;
                            },
                            prefix: Icons.lock_outline,
                            label: 'password',
                            radius: 15.0,
                            suffix: ProjectRegisterCubit.get(context).suffix,
                            onPressedSuffix: () {
                              ProjectRegisterCubit.get(context).changePassVisibility();
                            },
                            isPassword: ProjectRegisterCubit.get(context).isPassword,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) => state is! ProjectRegisterLoadingState,
                            widgetBuilder: (context) => buildTextButton(
                              onPressedTextButton: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ProjectRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    //image: imageController.text,
                                  );
                                }
                                // ProjectRegisterCubit.get(context).userCreate(
                                //   name: nameController.text,
                                //   phone: phoneController.text,
                                //   email: emailController.text,
                                //   uid: uid!,
                                // );
                              },
                              text: 'Sign out',
                              radius: 10.0,
                            ),
                            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
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