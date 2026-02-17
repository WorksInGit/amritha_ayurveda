class Treatment {
  final int id;
  final String name;
  final String price;

  Treatment({required this.id, required this.name, this.price = '0'});

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price']?.toString() ?? '0',
    );
  }

  @override
  String toString() => name;
}
