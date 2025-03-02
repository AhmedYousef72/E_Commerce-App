import 'package:e_commerce/blocs/product/product_bloc.dart';
import 'package:e_commerce/widgets/bottom_nav_bar.dart';
import 'package:e_commerce/widgets/category_filter.dart';
import 'package:e_commerce/widgets/featured_product_banner.dart';
import 'package:e_commerce/widgets/hot_deals_header.dart';
import 'package:e_commerce/widgets/product_grid.dart';
import 'package:e_commerce/widgets/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ProductLoaded) {
              return Stack(
                children: [
                  // Background gradient container
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.4, 1.0],
                        colors: [
                          Color.fromRGBO(254, 181, 174, 1), // Starting color
                          Color.fromRGBO(254, 181, 174, 0.5), // Mid transition
                          Colors.white, // End color
                        ],
                      ),
                    ),
                  ),

                  // Main content
                  SafeArea(
                    child: CustomScrollView(
                      slivers: [
                        // Status bar
                        SliverToBoxAdapter(child: StatusBar()),

                        // Header with location and profile
                        SliverToBoxAdapter(child: _buildHeader(context)),

                        // Main heading
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                            child: Text(
                              'Find best device for\nyour setup!',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),

                        // Featured product banner
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: FeaturedProductBanner(
                              product: state.featuredProduct,
                            ),
                          ),
                        ),

                        // Hot deals section
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: Column(
                              children: [
                                HotDealsHeader(),
                                SizedBox(height: 16),
                                SizedBox(
                                  height: 220,
                                  child: ProductGrid(
                                    products: state.hotDeals,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Categories section
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),

                        // Category filter
                        SliverToBoxAdapter(
                          child: CategoryFilter(
                            categories: state.categories,
                            onCategorySelected: (category) {
                              context.read<ProductBloc>().add(
                                FilterProductsByCategory(category),
                              );
                            },
                          ),
                        ),

                        // Product grid
                        SliverPadding(
                          padding: const EdgeInsets.all(24),
                          sliver: ProductGrid(
                            products: state.filteredProducts,
                            scrollDirection: Axis.vertical,
                            isSliver: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text('Something went wrong!'));
          },
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Location section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Condong Catur',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Notification and profile
          Row(
            children: [
              // Notification bell
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),

              // Profile picture with badge
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                  ),

                  // Notification badge
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '44',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
