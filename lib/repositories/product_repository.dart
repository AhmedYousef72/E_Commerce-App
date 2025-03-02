import 'package:flutter/material.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/models/category_model.dart';

class ProductRepository {
  // In-memory product database
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'New Bing Wireless Earphone',
      description: 'Premium wireless earphones with noise cancellation',
      price: 199.99,
      imageUrl: 'assets/images/headphones.png',
      category: 'Accessories',
      isFeatured: true,
    ),
    Product(
      id: 2,
      name: 'Macbook Pro 15" 2019 - Intel core i7',
      description: 'Powerful laptop for professionals',
      price: 1240,
      imageUrl: 'assets/images/macbook.png',
      category: 'Laptop',
      badge: 'NEW ARRIVAL',
    ),
    Product(
      id: 3,
      name: 'New True Wireless Stereo Earbuds',
      description: 'High-quality wireless earbuds',
      price: 462,
      originalPrice: 572,
      imageUrl: 'assets/images/earbuds.png',
      category: 'Accessories',
      badge: 'NEW - 30% OFF',
    ),
    Product(
      id: 4,
      name: 'Sound White Wireless Portable',
      description: 'Portable Bluetooth speaker',
      price: 240,
      originalPrice: 540,
      imageUrl: 'assets/images/speaker.png',
      category: 'Accessories',
      badge: '25% OFF',
    ),
    Product(
      id: 5,
      name: 'Apple AirPods (2nd Generation)',
      description: 'Wireless earbuds with charging case',
      price: 108,
      originalPrice: 129,
      imageUrl: 'assets/images/airpods.png',
      category: 'Accessories',
      badge: 'OUT OF STOCK',
    ),
    // Additional products for search functionality
    Product(
      id: 6,
      name: 'Macbook pro M2 Chip 2020',
      description: 'Latest MacBook with M2 processor',
      price: 462,
      imageUrl: 'assets/images/macbook_m2.png',
      category: 'Laptop',
      badge: 'NEW ARRIVAL',
    ),
    Product(
      id: 7,
      name: 'Macbook Pro 16" M1 Max Chip',
      description: 'High-performance MacBook for professionals',
      price: 1440,
      originalPrice: 1540,
      imageUrl: 'assets/images/macbook_pro_16.png',
      category: 'Laptop',
      badge: '25% OFF',
    ),
    Product(
      id: 8,
      name: 'Macbook Air M1 Chip 2020',
      description: 'Lightweight MacBook with M1 processor',
      price: 240,
      imageUrl: 'assets/images/macbook_air_m1.png',
      category: 'Laptop',
    ),
    Product(
      id: 9,
      name: 'MacBook Air 2017 - Intel Core i5',
      description: 'Affordable MacBook for everyday use',
      price: 180,
      originalPrice: 220,
      imageUrl: 'assets/images/macbook_air_2017.png',
      category: 'Laptop',
      badge: '20% OFF',
    ),
    Product(
      id: 10,
      name: 'Macbook Pro 16" M1 Pro Chip',
      description: 'Powerful MacBook for creative professionals',
      price: 1200,
      imageUrl: 'assets/images/macbook_pro_16_m1pro.png',
      category: 'Laptop',
    ),
  ];

  Future<List<Product>> getProducts() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    return _products;
  }

  Future<List<Category>> getCategories() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));

    return [
      Category(id: 'all', name: 'All', icon: Icons.apps),
      Category(id: 'laptop', name: 'Laptop', icon: Icons.laptop),
      Category(id: 'accessories', name: 'Accessories', icon: Icons.headphones),
    ];
  }

  Future<List<Product>> searchProducts({
    required String query,
    double? minPrice,
    double? maxPrice,
  }) async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 300));

    // Filter products based on search query and price range
    return _products.where((product) {
      // Check if product name or description contains the search query
      final matchesQuery =
          product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase());

      // Check if product price is within the specified range
      final withinPriceRange =
          (minPrice == null || product.price >= minPrice) &&
          (maxPrice == null || product.price <= maxPrice);

      return matchesQuery && withinPriceRange;
    }).toList();
  }
}
