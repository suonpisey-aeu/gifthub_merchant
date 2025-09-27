class Merchant {
  final String id;
  final String businessName;
  final String email;
  final String phone;
  final String address;
  final String category;
  final bool isActive;
  final double commissionRate;
  final DateTime createdAt;

  Merchant({
    required this.id,
    required this.businessName,
    required this.email,
    required this.phone,
    required this.address,
    required this.category,
    required this.isActive,
    required this.commissionRate,
    required this.createdAt,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'],
      businessName: json['business_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      category: json['category'],
      isActive: json['is_active'],
      commissionRate: json['commission_rate'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}