class Barang {
  final int? id;
  final String name;
  final String price;
  final String description;
  final int quantity;

  Barang({this.id, required this.name, required this.price, required this.description, this.quantity = 1});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }

  factory Barang.fromMap(Map<String, Object?> map) {
    return Barang(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as String,
      description: map['description'] as String,
      quantity: map['quantity'] as int,
    );
  }
}
