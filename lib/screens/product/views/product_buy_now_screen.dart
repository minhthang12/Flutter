import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/components/cart_button.dart';
import 'package:shop/components/custom_modal_bottom_sheet.dart';
import 'package:shop/components/network_image_with_loader.dart';
import 'package:shop/screens/product/views/added_to_cart_message_screen.dart';
import 'package:shop/screens/product/views/components/product_list_tile.dart';
import 'package:shop/screens/product/views/location_permission_store_availability_screen.dart';
import 'package:shop/screens/product/views/size_guide_screen.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/tokenStorage/token_storage.dart';

import '../../../constants.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';

class ProductBuyNowScreen extends StatefulWidget {
  const ProductBuyNowScreen(
      {super.key,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.productImageUrl});
  final int productId;
  final String productName;
  final int productPrice;
  final String productImageUrl;
  @override
  _ProductBuyNowScreenState createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {
  int quantity = 1;
  int selectSize = 1;
  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double totalPrice() {
    return (widget.productPrice * quantity).toDouble();
  }

  void addToCard() async {
    final response = await ApiService.addToCart(
        productId: widget.productId, quantity: quantity);
    if (response.statusCode == 201) {
      print("Product added to cart successfully!");
    } else {
      print("Failed to add product");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartButton(
        price: totalPrice(),
        title: "Thêm vào giỏ hàng",
        subTitle: "Tổng tiền",
        press: () {
          addToCard();
          customModalBottomSheet(
            context,
            isDismissible: false,
            child: const AddedToCartMessageScreen(),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                Text(
                  widget.productName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(widget.productImageUrl),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            // price: 145,
                            priceAfterDiscount: widget.productPrice.toDouble(),
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: quantity,
                          onIncrement: () {
                            increment();
                          },
                          onDecrement: () {
                            decrement();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                // SliverToBoxAdapter(
                //   child: SelectedColors(
                //     colors: const [
                //       Color(0xFFEA6262),
                //       Color(0xFFB1CC63),
                //       Color(0xFFFFBF5F),
                //       Color(0xFF9FE1DD),
                //       Color(0xFFC482DB),
                //     ],
                //     selectedColorIndex: 2,
                //     press: (value) {},
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: SelectedSize(
                    sizes: const ["S", "M", "L", "XL", "XXL"],
                    selectedIndex: selectSize,
                    press: (value) {
                      setState(() {
                        selectSize = value;
                      });
                    },
                  ),
                ),
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                //   sliver: ProductListTile(
                //     title: "Size guide",
                //     svgSrc: "assets/icons/Sizeguid.svg",
                //     isShowBottomBorder: true,
                //     press: () {
                //       customModalBottomSheet(
                //         context,
                //         height: MediaQuery.of(context).size.height * 0.9,
                //         child: const SizeGuideScreen(),
                //       );
                //     },
                //   ),
                // ),
                // SliverPadding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: defaultPadding),
                //   sliver: SliverToBoxAdapter(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const SizedBox(height: defaultPadding / 2),
                //         Text(
                //           "Store pickup availability",
                //           style: Theme.of(context).textTheme.titleSmall,
                //         ),
                //         const SizedBox(height: defaultPadding / 2),
                //         const Text(
                //             "Select a size to check store availability and In-Store pickup options.")
                //       ],
                //     ),
                //   ),
                // ),
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                //   sliver: ProductListTile(
                //     title: "Check stores",
                //     svgSrc: "assets/icons/Stores.svg",
                //     isShowBottomBorder: true,
                //     press: () {
                //       customModalBottomSheet(
                //         context,
                //         height: MediaQuery.of(context).size.height * 0.92,
                //         child: const LocationPermissonStoreAvailabilityScreen(),
                //       );
                //     },
                //   ),
                // ),
                const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding))
              ],
            ),
          )
        ],
      ),
    );
  }
}
