class Branch {
  final int id;
  final String name;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String gst;

  Branch({
    required this.id,
    required this.name,
    this.location = '',
    this.phone = '',
    this.mail = '',
    this.address = '',
    this.gst = '',
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
      gst: json['gst'] ?? '',
    );
  }

  @override
  String toString() => name;
}
