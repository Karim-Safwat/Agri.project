
import 'package:final_agriculture_project/components/components.dart';
import 'package:final_agriculture_project/layout/home_screen.dart';
import 'package:final_agriculture_project/modules/login/cubit/cubit.dart';
import 'package:final_agriculture_project/modules/login/cubit/states.dart';
import 'package:final_agriculture_project/modules/register/Register_Screen.dart';
import 'package:final_agriculture_project/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

var emailController = TextEditingController();
var passwordController = TextEditingController();
var formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectLoginCubit(),
      child: BlocConsumer<ProjectLoginCubit, ProjectLoginStates>(
        listener: (context, state)
        {
          if(state is ProjectLoginErrorState){
            showToast(text: state.error,state: ToastState.error);
          }
          if(state is ProjectLoginSuccessState){
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value)
            {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutScreen(),
                ),
                    (Route<dynamic>route)=>false,
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          'LOGIN',
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'login to manage your agriculture fields...',
                          maxLines: 2,
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                            fontSize: 20.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email address must not be empty';
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
                                return 'password must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.lock_outline,
                            label: 'password',
                            radius: 15.0,
                            isPassword: ProjectLoginCubit.get(context).isPassword,
                            suffix: ProjectLoginCubit.get(context).suffix,
                            onPressedSuffix: () {
                              ProjectLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) => state is! ProjectLoginLoadingState,
                            widgetBuilder: (context) => buildTextButton(
                              onPressedTextButton: () {
                                if (formKey.currentState!.validate())
                                {
                                  ProjectLoginCubit.get(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              radius: 10.0,
                            ),
                            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have Account ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.grey
                              ),
                            ),
                            buildDefaultTextButton(
                              onPressedTextButton: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const RegisterScreen(),
                                  ),
                                );
                              },
                              text: 'sign out',
                            ),
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