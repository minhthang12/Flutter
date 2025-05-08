import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/components/buy_full_ui_kit.dart';
import 'package:shop/components/cart_button.dart';
import 'package:shop/components/custom_modal_bottom_sheet.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/constants.dart';
import 'package:shop/screens/product/views/product_returns_screen.dart';
import 'package:shop/models/product.dart';

import 'package:shop/route/screen_export.dart';

import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import '../../../components/review_card.dart';
import 'product_buy_now_screen.dart';
import 'package:shop/services/api_service.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.isProductAvailable = true,
  });
  final int productId;
  final bool isProductAvailable;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenSate();
}

class _ProductDetailsScreenSate extends State<ProductDetailsScreen> {
  Product? products;
  bool isLoading = true;
  String? errorMessage;
  List<Product> productList = [];
  @override
  void initState() {
    super.initState();
    loadProductsById();
  }

  Future<void> loadProductsById() async {
    try {
      final result = await ApiService.fetchProductById(widget.productId);
      setState(() {
        products = result;
        isLoading = false;
      });
      await fetchProductsByCategory();
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> fetchProductsByCategory() async {
    try {
      final result =
          await ApiService.fetchProductsByCategory(products!.categoryId);
      final filterList =
          result.where((product) => product.id != products!.id).toList();
      setState(() {
        productList = filterList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      bottomNavigationBar: widget.isProductAvailable
          ? CartButton(
              price: products!.price.toDouble(),
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: ProductBuyNowScreen(
                    productId: products!.id,
                    productName: products!.productName,
                    productPrice: products!.price,
                    productImageUrl: products!.pictures,
                  ),
                );
              },
            )
          :

          /// If profuct is not available then show [NotifyMeCard]
          NotifyMeCard(
              isNotify: false,
              onChanged: (value) {},
            ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
            ProductImages(
              images: [
                products!.pictures,
                products!.pictures,
                products!.pictures
              ],
            ),
            ProductInfo(
              brand: "",
              title: products!.productName,
              isAvailable: widget.isProductAvailable,
              description: products!.productDescription,
              rating: 4.4,
              numOfReviews: 126,
              price: products?.price,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Có thể bạn sẽ thích ",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: productList.isEmpty
                    ? const Center(child: Text("Không có sản phẩm tương tự"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productList.length,
                        itemBuilder: (context, index) {
                          final product = productList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: index == productList.length - 1
                                  ? defaultPadding
                                  : 0,
                            ),
                            child: ProductCard(
                              image: product.pictures,
                              title: product.productName,
                              brandName: "",
                              price: product.price.toDouble(),
                              // priceAfetDiscount: product.price.toDouble(),
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
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
