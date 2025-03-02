import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/repositories/wishlist_repository.dart';

// Events
abstract class WishlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWishlist extends WishlistEvent {}

class AddToWishlist extends WishlistEvent {
  final Product product;

  AddToWishlist(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromWishlist extends WishlistEvent {
  final Product product;

  RemoveFromWishlist(this.product);

  @override
  List<Object> get props => [product];
}

// States
abstract class WishlistState extends Equatable {
  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> wishlistItems;

  WishlistLoaded({required this.wishlistItems});

  @override
  List<Object> get props => [wishlistItems];
}

class WishlistError extends WishlistState {
  final String message;

  WishlistError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;

  WishlistBloc({required this.wishlistRepository}) : super(WishlistLoading()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
  }

  void _onLoadWishlist(LoadWishlist event, Emitter<WishlistState> emit) async {
    emit(WishlistLoading());
    try {
      final wishlistItems = await wishlistRepository.getWishlistItems();
      emit(WishlistLoaded(wishlistItems: wishlistItems));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  void _onAddToWishlist(
    AddToWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        final currentState = state as WishlistLoaded;
        await wishlistRepository.addToWishlist(event.product);
        emit(
          WishlistLoaded(
            wishlistItems: List.from(currentState.wishlistItems)
              ..add(event.product),
          ),
        );
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    }
  }

  void _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      try {
        final currentState = state as WishlistLoaded;
        await wishlistRepository.removeFromWishlist(event.product);
        emit(
          WishlistLoaded(
            wishlistItems: List.from(currentState.wishlistItems)
              ..removeWhere((product) => product.id == event.product.id),
          ),
        );
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    }
  }
}
