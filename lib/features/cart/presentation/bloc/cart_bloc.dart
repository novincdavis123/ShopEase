import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(const CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _emitCart(Emitter<CartState> emit) async {
    final items = await repository.getCartItems();
    final total = await repository.getTotalPrice();

    emit(CartLoaded(items: items, totalPrice: total));
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(const CartLoading());

    try {
      await _emitCart(emit);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await repository.addToCart(event.item);

      await _emitCart(emit);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await repository.removeFromCart(event.productId);

      await _emitCart(emit);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onIncreaseQuantity(
    IncreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await repository.increaseQuantity(event.productId);

      await _emitCart(emit);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onDecreaseQuantity(
    DecreaseQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await repository.decreaseQuantity(event.productId);

      await _emitCart(emit);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      await repository.clearCart();

      await _emitCart(emit);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
