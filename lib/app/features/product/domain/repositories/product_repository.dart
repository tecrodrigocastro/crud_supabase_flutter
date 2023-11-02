import 'package:supabase_crud_app/app/features/dashboard/domain/entities/product_entity.dart';
import 'package:supabase_crud_app/app/features/product/domain/usecases/add_product_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final supabase = Supabase.instance.client;

  Future addProduct(AddProductUseCase useCase) async {
    final response = await supabase.from('products').insert(
      {
        'name': useCase.name,
        'image': useCase.image,
        'price': useCase.price,
        'size': useCase.size,
      },
    );
    return response;
  }

  Future deleteProduct(ProductEntity product) async {
    await supabase.from('products').delete().match({'id': product.id});
  }
}
