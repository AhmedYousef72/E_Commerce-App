import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class FilterProductsByCategory extends ProductEvent {
  final Category category;

  FilterProductsByCategory(this.category);

  @override
  List<Object> get props => [category];
}

// States
abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final List<Product> hotDeals;
  final Product featuredProduct;
  final List<Category> categories;
  final Category selectedCategory;

  ProductLoaded({
    required this.products,
    required this.filteredProducts,
    required this.hotDeals,
    required this.featuredProduct,
    required this.categories,
    required this.selectedCategory,
  });

  @override
  List<Object> get props => [
    products,
    filteredProducts,
    hotDeals,
    featuredProduct,
    categories,
    selectedCategory,
  ];

  ProductLoaded copyWith({
    List<Product>? products,
    List<Product>? filteredProducts,
    List<Product>? hotDeals,
    Product? featuredProduct,
    List<Category>? categories,
    Category? selectedCategory,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      hotDeals: hotDeals ?? this.hotDeals,
      featuredProduct: featuredProduct ?? this.featuredProduct,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterProductsByCategory>(_onFilterProductsByCategory);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.getProducts();
      final categories = await productRepository.getCategories();
      final featuredProduct = products.firstWhere(
        (product) => product.isFeatured,
      );
      final hotDeals = products.take(4).toList();

      emit(
        ProductLoaded(
          products: products,
          filteredProducts: products,
          hotDeals: hotDeals,
          featuredProduct: featuredProduct,
          categories: categories,
          selectedCategory: categories.first,
        ),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onFilterProductsByCategory(
    FilterProductsByCategory event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      final filteredProducts =
          event.category.id == 'all'
              ? currentState.products
              : currentState.products
                  .where(
                    (product) =>
                        product.category.toLowerCase() ==
                        event.category.name.toLowerCase(),
                  )
                  .toList();

      emit(
        currentState.copyWith(
          filteredProducts: filteredProducts,
          selectedCategory: event.category,
        ),
      );
    }
  }
}
