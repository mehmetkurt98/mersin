
class Pharmacy {
  final String name;
  final String dist;
  final String address;
  final String phone;
  final String loc;

  Pharmacy({required this.name, required this.dist, required this.address, required this.phone, required this.loc});

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      name: json['name'] ?? '',
      dist: json['dist'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      loc: json['loc'] ?? '',
    );
  }
}