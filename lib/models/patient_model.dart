class Patient {
  final int id;
  final String? name;
  final String? treatmentName;
  final DateTime? date;
  final String? user;
  final String? branchName;
  final String? payment;

  Patient({
    required this.id,
    required this.name,
    required this.treatmentName,
    this.date,
    required this.user,
    required this.branchName,
    required this.payment,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    String? treatment;
    if (json['patientdetails_set'] != null) {
      final details = json['patientdetails_set'] as List;
      treatment = details
          .map((e) => e['treatment_name']?.toString())
          .where((e) => e != null)
          .join(", ");
    }

    return Patient(
      id: json['id'],
      name: json['name'],
      treatmentName: treatment,
      date: json['date_nd_time'] != null
          ? DateTime.tryParse(json['date_nd_time'])
          : null,
      user: json['user'],
      branchName: json['branch']?['name'],
      payment: json['payment'],
    );
  }
}
