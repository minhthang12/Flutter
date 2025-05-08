import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'categories.dart';
import 'offers_carousel.dart';
import 'package:shop/models/product.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  final Function(List<Product>) onCategorySelected;
  const OffersCarouselAndCategories({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        // const OffersSkelton(),
        const OffersCarousel(),
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Danh mục sản phẩm",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const CategoriesSkelton(),
        Categories(onCategorySelected: onCategorySelected),
      ],
    );
  }
}
