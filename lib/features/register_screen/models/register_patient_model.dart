class RegisterPatientModel {
  final String name;
  final String excecutive;
  final String payment;
  final String phone;
  final String address;
  final String totalAmount;
  final String discountAmount;
  final String advanceAmount;
  final String balanceAmount;
  final String dateAndTime;
  final String id;
  final String male;
  final String female;
  final String branch;
  final String treatments;

  RegisterPatientModel({
    required this.name,
    required this.excecutive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    required this.id,
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'excecutive': excecutive,
      'payment': payment,
      'phone': phone,
      'address': address,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateAndTime,
      'id': id,
      'male': male,
      'female': female,
      'branch': branch,
      'treatments': treatments,
    };
  }
}
