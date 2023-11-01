import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductEntity {
  final int id;
  final String name;
  final int price;
  final String size;
  final String image;
  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'size': size,
      'image': image,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as int,
      size: map['size'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromJson(String source) =>
      ProductEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
