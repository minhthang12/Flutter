import 'package:flutter/material.dart';
import 'package:shop/components/Banner/S/banner_s_style_1.dart';
import 'package:shop/components/Banner/S/banner_s_style_5.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/screen_export.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';

import 'components/best_sellers.dart';
import 'components/flash_sale.dart';
import 'components/most_popular.dart';
import 'components/offer_carousel_and_categories.dart';
import 'components/popular_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: OffersCarouselAndCategories()),
            // const SliverToBoxAdapter(child: PopularProducts()),
            // const SliverPadding(
            //   padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
            //   sliver: SliverToBoxAdapter(child: FlashSale()),
            // ),
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       BannerSStyle1(
            //         title: "New \narrival",
            //         subtitle: "SPECIAL OFFER",
            //         discountParcent: 50,
            //         press: () {
            //           Navigator.pushNamed(context, onSaleScreenRoute);
            //         },
            //       ),
            //       const SizedBox(height: defaultPadding / 4),
            //     ],
            //   ),
            // ),
            // const SliverToBoxAdapter(child: BestSellers()),
            // const SliverToBoxAdapter(child: MostPopular()),
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       const SizedBox(height: defaultPadding * 1.5),
            //       BannerSStyle5(
            //         title: "Black \nfriday",
            //         subtitle: "50% Off",
            //         bottomText: "COLLECTION",
            //         press: () {
            //           Navigator.pushNamed(context, onSaleScreenRoute);
            //         },
            //       ),
            //       const SizedBox(height: defaultPadding / 4),
            //     ],
            //   ),
            // ),
            // const SliverToBoxAdapter(child: BestSellers()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: defaultPadding,
                  crossAxisSpacing: defaultPadding,
                  childAspectRatio: 0.66,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ProductCard(
                      image: demoPopularProducts[index].image,
                      brandName: demoPopularProducts[index].brandName,
                      title: demoPopularProducts[index].title,
                      price: demoPopularProducts[index].price,
                      priceAfetDiscount:
                          demoPopularProducts[index].priceAfetDiscount,
                      dicountpercent:
                          demoPopularProducts[index].dicountpercent,
                      press: () {
                        Navigator.pushNamed(
                            context, productDetailsScreenRoute);
                      },
                    );
                  },
                  childCount: demoPopularProducts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
