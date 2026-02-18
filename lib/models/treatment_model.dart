class Treatment {
  final int? id;
  final String? name;
  final String? duration;
  final String? price;

  Treatment({this.id, this.name, this.duration, this.price});

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'],
      name: json['name'],
      duration: json['duration']?.toString(),
      price: json['price']?.toString(),
    );
  }

  @override
  String toString() => name ?? 'Unknown';
}
