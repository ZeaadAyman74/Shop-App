import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import '../../shared/components/components.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if(state is RegisterSuccessState){
              if(RegisterCubit.get(context).loginModel?.status==true){
                showToast(message: RegisterCubit.get(context).loginModel!.message!, state: ToastStates.SUCCESS);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }
            }else{
              showToast(message: RegisterCubit.get(context).loginModel!.message!, state: ToastStates.ERROR);

            }
          },
          builder: (context, state) {
            RegisterCubit cubit = RegisterCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,70),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/signup.png'),
                        Text(
                          "REGISTER",
                          style:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        defaultFormField(context: context,

                          myController: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          label: "Name",
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(context: context,
                          myController: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          label: "Email Address",
                          prefix: Icons.email,
                        ),
                        const SizedBox(height: 20,),
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
                        defaultFormField(context: context,
                          myController: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          label: "Phone",
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (_) =>
                              defaultButton(
                                txt: "REGISTER",
                                radius: 5,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.register(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                        phone: phoneController.text
                                    );
                                  }
                                },
                              ),
                          fallback: (_) =>
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ),
            );
          }),
    );
  }
}

