import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product.dart';
import 'package:shop/route/screen_export.dart';
import 'package:shop/services/api_service.dart';

import 'components/offer_carousel_and_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadInitialProducts();
  }
  Future<void> loadInitialProducts() async {
    final products = await ApiService.fetchProducts();
    setState(() {
      productList = products;
      isLoading = false;
    });
  }

  void updateProducts(List<Product> newProducts) {
    setState(() {
      productList = [];
      productList = newProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: OffersCarouselAndCategories(
              onCategorySelected: updateProducts,
            )),
            SliverToBoxAdapter(
              child: productList.isEmpty
                  ? const Center(child: Text("Không có sản phẩm nào"))
                  : Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productList.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          mainAxisSpacing: defaultPadding,
                          crossAxisSpacing: defaultPadding,
                          childAspectRatio: 0.66,
                        ),
                        itemBuilder: (context, index) {
                          final product = productList[index];
                          return ProductCard(
                            image: product.pictures,
                            brandName: "Brand",
                            title: product.productName,
                            price: product.price.toDouble(),
                            priceAfetDiscount: product.price.toDouble(),
                            dicountpercent: 0,
                            press: () {
                              Navigator.pushNamed(
                                context,
                                productDetailsScreenRoute,
                                arguments: {
                                  'productId': product.id,
                                  'isProductAvailable': true,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
