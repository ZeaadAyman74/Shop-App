import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_cubit/layout_cubit.dart';
import 'package:shop_app/layout/shop_cubit/layout_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/products/products_details.dart';
import 'package:shop_app/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is ChangeFavoritesSuccessState) {
          if (LayoutCubit.get(context).changeFavoritesModel?.status == false) {
            showToast(message: LayoutCubit.get(context).changeFavoritesModel!.message,
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) => pageBuilder(cubit.homeModel, cubit.categoryModel, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget pageBuilder(HomeModel? model, CategoryModel? category, context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
              items: model?.data?.banners
                  .map((e) => Image(
                        image: NetworkImage(
                          '${e.image}',
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                initialPage: 0,
                scrollDirection: Axis.horizontal,
                reverse: false,
                enableInfiniteScroll: true,
                viewportFraction: 0.97,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Categories",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith( fontSize: 25,
                      fontWeight: FontWeight.w800,),
                  ),
                  const SizedBox(height: 10,),

                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => categoryItemBuilder(
                          category!.data!.categoryData[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: category!.data!.categoryData.length,
                    ),
                  ), // Categories***************
                  const SizedBox(
                    height: 20,
                  ),
                   Text(
                    "New Products",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith( fontSize: 25,
                    fontWeight: FontWeight.w800,),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
            // Categories*************************
            Container(
              color: const Color(0XFFE1E1E3),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 5,
                childAspectRatio: 1 / 1.7,
                children: model!.data!.products
                    .map((element) => productItemBuilder(element, context))
                    .toList(),
              ),
            ),
          ],
        ),
      );
}
