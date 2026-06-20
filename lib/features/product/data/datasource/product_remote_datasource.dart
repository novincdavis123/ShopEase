import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('/products');

      if (response.statusCode == 200) {
        final List products = response.data['products'];

        return products.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Network error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
