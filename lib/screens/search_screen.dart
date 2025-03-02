import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/blocs/search/search_bloc.dart';
import 'package:e_commerce/widgets/bottom_nav_bar.dart';
import 'package:e_commerce/widgets/price_filter_sheet.dart';
import 'package:e_commerce/widgets/search_product_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;
  RangeValues _currentPriceRange = RangeValues(160, 1960);
  bool _isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });

      // Search as user types
      if (_searchController.text.isNotEmpty) {
        context.read<SearchBloc>().add(
          SearchProducts(
            query: _searchController.text,
            minPrice: _isFilterApplied ? _currentPriceRange.start : null,
            maxPrice: _isFilterApplied ? _currentPriceRange.end : null,
          ),
        );
      } else {
        context.read<SearchBloc>().add(ClearSearch());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<SearchBloc>().add(ClearSearch());
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => PriceFilterSheet(
            currentPriceRange: _currentPriceRange,
            onApplyFilter: (range) {
              setState(() {
                _currentPriceRange = range;
                _isFilterApplied = true;
              });
              Navigator.pop(context);
              if (_searchController.text.isNotEmpty) {
                context.read<SearchBloc>().add(
                  SearchProducts(
                    query: _searchController.text,
                    minPrice: _currentPriceRange.start,
                    maxPrice: _currentPriceRange.end,
                  ),
                );
              }
            },
            onResetFilter: () {
              setState(() {
                _currentPriceRange = RangeValues(160, 1960);
                _isFilterApplied = false;
              });
              Navigator.pop(context);
              if (_searchController.text.isNotEmpty) {
                context.read<SearchBloc>().add(
                  SearchProducts(
                    query: _searchController.text,
                    minPrice: null,
                    maxPrice: null,
                  ),
                );
              }
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.grey[700]),
                      ),
                    ),
                    SizedBox(width: 8),
                    // Search input
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                            ),
                            suffixIcon:
                                _showClearButton
                                    ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.grey[600],
                                      ),
                                      onPressed: _clearSearch,
                                    )
                                    : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Search results
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchLoaded) {
                      if (state.searchResults.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No results found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Try a different search term or filter',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          // Search result header
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Result for "${state.searchQuery}"',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  '${state.searchResults.length} found${state.searchResults.length == 1 ? '' : 's'}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),

                          // Product grid
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.7,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                  ),
                              itemCount: state.searchResults.length,
                              itemBuilder: (context, index) {
                                return SearchProductCard(
                                  product: state.searchResults[index],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    // Initial state or error state
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 64, color: Colors.grey[400]),
                          SizedBox(height: 16),
                          Text(
                            'Search for products',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:
            _searchController.text.isNotEmpty
                ? FloatingActionButton.extended(
                  onPressed: _showFilterBottomSheet,
                  backgroundColor: Color(0xFF2D3142),
                  label: Text('Filter'),
                  icon: Icon(Icons.filter_list),
                )
                : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
