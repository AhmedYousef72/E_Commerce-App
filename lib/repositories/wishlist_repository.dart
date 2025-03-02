import 'package:e_commerce/models/product_model.dart';

class WishlistRepository {
  // In a real app, this would be stored in a database or shared preferences
  List<Product> _wishlistItems = [];

  Future<List<Product>> getWishlistItems() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));

    // For demo purposes, if wishlist is empty, populate with some items
    if (_wishlistItems.isEmpty) {
      _wishlistItems = [
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
        ),
        Product(
          id: 4,
          name: 'Sound White Wireless Portable',
          description: 'Portable Bluetooth speaker',
          price: 240,
          originalPrice: 540,
          imageUrl: 'assets/images/speaker.png',
          category: 'Accessories',
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
      ];
    }

    return _wishlistItems;
  }

  Future<void> addToWishlist(Product product) async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 300));

    if (!_wishlistItems.any((item) => item.id == product.id)) {
      _wishlistItems.add(product);
    }
  }

  Future<void> removeFromWishlist(Product product) async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 300));

    _wishlistItems.removeWhere((item) => item.id == product.id);
  }
}
