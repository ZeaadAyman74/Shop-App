import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../layout/shop_cubit/layout_states.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  //var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is UpdateUserDataSuccess) {
          if (LayoutCubit.get(context).userModel?.status == true) {
            showToast(
                message: LayoutCubit.get(context).userModel!.message!,
                state: ToastStates.SUCCESS);
          } else {
            showToast(
                message: LayoutCubit.get(context).userModel!.message!,
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);

        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;

        return Scaffold(
          appBar: AppBar(title: const Text("Account",style: TextStyle(fontSize: 20),),),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key:formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(state is UpdateUserLoading)
                      const LinearProgressIndicator() ,
                    const SizedBox(height: 10,),
                    defaultFormField(context: context,
                      myController: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'cannot be empty';
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
                          return 'cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      label: "Email",
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(context: context,
                      myController: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      label: "Phone",
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultButton(
                        txt: "UPDATE",
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        radius: 15),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
