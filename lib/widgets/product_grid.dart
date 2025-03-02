import 'package:flutter/material.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final Axis scrollDirection;
  final bool isSliver;

  const ProductGrid({
    Key? key,
    required this.products,
    this.scrollDirection = Axis.vertical,
    this.isSliver = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return ProductCard(product: products[index]);
        }, childCount: products.length),
      );
    }

    if (scrollDirection == Axis.horizontal) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            child: ProductCard(product: products[index]),
          );
        },
      );
    }

    // Fixed the error by using ListView.builder instead of GridView.builder
    // GridView.builder with NeverScrollableScrollPhysics was causing issues
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (products.length / 2).ceil(),
      itemBuilder: (context, rowIndex) {
        List<Widget> children = [];
        for (int i = 0; i < 2; i++) {
          final index = rowIndex * 2 + i;
          if (index < products.length) {
            children.add(
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: i == 0 ? 0 : 8,
                    right: i == 1 ? 0 : 8,
                    bottom: 16,
                  ),
                  child: ProductCard(product: products[index]),
                ),
              ),
            );
          } else {
            children.add(Expanded(child: SizedBox()));
          }
        }
        return Row(children: children);
      },
    );
  }
}
