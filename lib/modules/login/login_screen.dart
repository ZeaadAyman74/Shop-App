import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

//zeaadayman@gmail.com
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
               if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              showToast(message: state.loginModel.message!, state: ToastStates.SUCCESS);
              CacheHelper.putData(key:'token', value: state.loginModel.data?.token).then((value) {
                if(value){
                  token=state.loginModel.data?.token;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>const ShopLayoutScreen()));
                }
              });
            } else {
              showToast(message: state.loginModel.message!, state: ToastStates.ERROR);
            }
          }
        },
                builder: (context, state) {
              LoginCubit cubit = LoginCubit.get(context);
              return SafeArea(
                child: Scaffold(
                 body: Center(child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20,0,20,20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/login1.png'),
                          Text(
                            "LOGIN",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 40,
                                    ),

                          ),
                          SizedBox(height: 5,),
                          Text(
                            "login now to browse our hot offers",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormField(context: context,
                            myController: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(context: context,
                              myController: passController,
                              type: TextInputType.visiblePassword,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return "password cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              label: "Password",
                              prefix: Icons.lock,
                              isPassword: cubit.isVisible,
                              sufix: cubit.visibleIcon,
                              sufixPress: () {
                                cubit.changePassVisibility();
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (_) => defaultButton(
                              txt: "login",
                              radius: 5,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.loginUser(
                                      email: emailController.text,
                                      password: passController.text);
                                }
                              },
                            ),
                            fallback: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text("Don't have an account? ",style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15),),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               RegisterScreen()));
                                },
                                child: const Text(
                                  "REGISTER",
                                  style: TextStyle(color: defaultColor),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
          ),
              );
        }));
  }
}
