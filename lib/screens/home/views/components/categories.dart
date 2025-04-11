import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/route/screen_export.dart';
import 'package:shop/services/api_service.dart';
import '../../../../constants.dart';
import 'package:shop/models/category.dart' as categoryModel;
import 'package:shop/models/product.dart';

// For preview
class Categories extends StatefulWidget {
  final Function(List<Product>) onCategorySelected;
  const Categories({super.key, required this.onCategorySelected});
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<categoryModel.Category> categories = [];
  bool isLoading = true;
  int selectedCategoryId = 0;
  @override
  void initState() {
    super.initState();
    loadCategories();
    
  }

  Future<void> loadCategories() async {
    try {
      final data = await ApiService.fetchCategories();
      setState(() {
        categories = [
          categoryModel.Category(id: 0, categoryName: "All Categories"),
          ...data
        ];
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading categories: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? defaultPadding : defaultPadding / 2,
                right: index == categories.length - 1 ? defaultPadding : 0),
            child: CategoryBtn(
                category: categories[index].categoryName,
                isActive: selectedCategoryId == categories[index].id,
                press: () async {
                  setState(() {
                    selectedCategoryId = categories[index].id;
                  });
                  if (categories[index].id != 0) {
                    final products = await ApiService.fetchProductsByCategory(
                        categories[index].id);
                    widget.onCategorySelected(products);
                  } else {
                    final allProducts = await ApiService.fetchProducts();
                    widget.onCategorySelected(allProducts);
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class CategoryBtn extends StatelessWidget {
  const CategoryBtn({
    super.key,
    required this.category,
    required this.isActive,
    required this.press,
  });

  final String category;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.transparent,
          border: Border.all(
              color: isActive
                  ? Colors.transparent
                  : Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }
}
