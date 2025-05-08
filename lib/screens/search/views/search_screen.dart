import 'package:flutter/material.dart';
import 'package:shop/components/buy_full_ui_kit.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> productList = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
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

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await loadInitialProducts();
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final products = await ApiService.searchProductByName(query);
      setState(() {
        productList = products; // không cần gán productList = [] trước
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Không thể tìm sản phẩm: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shoplon',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                Icon(Icons.close),
              ],
            ),
            SizedBox(height: 20),
            // Search box
            TextField(
              controller: _searchController,
              onChanged: (value) {
                searchProducts(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.tune),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            SizedBox(height: 20),
            // Search result title
            Text("Search result (${productList.length} items)",
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            // Display loading spinner or grid of products
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.6,
                            ),
                            itemCount: productList.length,
                            itemBuilder: (context, index) {
                              final product = productList[index];
                              return ProductCard(
                                image: product.pictures,
                                brandName: "Sản phẩm",
                                title: product.productName,
                                price: product.price.toDouble(),
                                dicountpercent: 0,
                                press: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/productDetails',
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
          ],
        ),
      ),
    );
  }
}
