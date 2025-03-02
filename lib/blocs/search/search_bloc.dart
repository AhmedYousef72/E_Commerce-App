import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/repositories/product_repository.dart';

// Events
abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchProducts extends SearchEvent {
  final String query;
  final double? minPrice;
  final double? maxPrice;

  SearchProducts({required this.query, this.minPrice, this.maxPrice});

  @override
  List<Object?> get props => [query, minPrice, maxPrice];
}

class ClearSearch extends SearchEvent {}

// States
abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> searchResults;
  final String searchQuery;

  SearchLoaded({required this.searchResults, required this.searchQuery});

  @override
  List<Object> get props => [searchResults, searchQuery];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepository;

  SearchBloc({required this.productRepository}) : super(SearchInitial()) {
    on<SearchProducts>(_onSearchProducts);
    on<ClearSearch>(_onClearSearch);
  }

  void _onSearchProducts(
    SearchProducts event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final searchResults = await productRepository.searchProducts(
        query: event.query,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
      );
      emit(
        SearchLoaded(searchResults: searchResults, searchQuery: event.query),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }
}
