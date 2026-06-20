import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    try {
      final products = await repository.getProducts();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
