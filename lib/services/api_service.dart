import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/category.dart';

class ApiService {
  static const String _baseUrl = "http://localhost:8080";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl/product/"));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse("$_baseUrl/category/"));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  static Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse("$_baseUrl/product/$categoryId"));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products by category");
    }
  }

  static Future<Product> fetchProductById(int productId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/product/singleProduct/$productId"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          jsonDecode(utf8.decode(response.bodyBytes));
      return Product.fromJson(body);
    } else {
      throw Exception("Failed to load product by ID");
    }
  }

  static Future<http.Response> loginUser(int phone, String password) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
    );
    return response;
  }
}
