import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';
import 'product_availability_tag.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.brand,
    required this.description,
    this.rating,
    required this.numOfReviews,
    this.price,
    required this.isAvailable,
  });

  final String title, brand, description;
  final double? rating;
  final int numOfReviews;
  final int? price;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              brand.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              title,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                // ProductAvailabilityTag(isAvailable: isAvailable),
                // const Spacer(),
                // SvgPicture.asset("assets/icons/Star_filled.svg"),
                // const SizedBox(width: defaultPadding / 4),
                // Text(
                //   "$rating ",
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                Text(
                  "\$$price",
                  style: const TextStyle(
                    color: Color(0xFF31B0D8),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: defaultPadding),
            Text(
              "Thông tin sản phẩm",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              description,
              style: const TextStyle(height: 1.4),
            ),
            const SizedBox(height: defaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
