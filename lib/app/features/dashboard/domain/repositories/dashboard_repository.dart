import 'package:supabase_crud_app/app/features/dashboard/domain/entities/product_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardRepository {
  final supabase = Supabase.instance.client;

  Future<List<ProductEntity>> fetchAllProducts() async {
    final result =
        await supabase.from('products').select<List<Map<String, dynamic>>>();
    final data = result.map((e) => ProductEntity.fromMap(e)).toList();
    return data;
  }
}
