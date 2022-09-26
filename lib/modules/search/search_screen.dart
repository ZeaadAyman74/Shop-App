import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SearchCubit.get(context);
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    defaultFormField(context:context ,
                        myController: searchController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter your Search !';
                          } else {
                            return null;
                          }
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        isBorder: true,
                        onSubmit: (String text) {
                          if (formKey.currentState!.validate()) {
                            SearchCubit.get(context).search(text);
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    if (state is GetSearchDataLoading)
                      const LinearProgressIndicator(),
                    if(state is GetSearchDataSuccess)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => favoriteItem(
                            cubit.model!.data!.data[index], context,isSearch:true),
                        separatorBuilder: (context, index) => const SizedBox(height: 30,width: double.infinity,),
                        itemCount: cubit.model!.data!.data.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
