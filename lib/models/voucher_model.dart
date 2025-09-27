enum VoucherStatus { active, inactive, expired, redeemed }

class VoucherTemplate {
  final String id;
  final String merchantId;
  final String title;
  final String description;
  final double originalPrice;
  final double discountedPrice;
  final String category;
  final DateTime validFrom;
  final DateTime validUntil;
  final int maxRedemptions;
  final int currentRedemptions;
  final VoucherStatus status;
  final String imageUrl;
  final List<String> terms;

  VoucherTemplate({
    required this.id,
    required this.merchantId,
    required this.title,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.category,
    required this.validFrom,
    required this.validUntil,
    required this.maxRedemptions,
    required this.currentRedemptions,
    required this.status,
    required this.imageUrl,
    required this.terms,
  });

  double get discountPercentage {
    return ((originalPrice - discountedPrice) / originalPrice) * 100;
  }
}

class VoucherTransaction {
  final String id;
  final String voucherId;
  final String consumerName;
  final String consumerEmail;
  final DateTime redeemedAt;
  final double amount;
  final String qrCode;

  VoucherTransaction({
    required this.id,
    required this.voucherId,
    required this.consumerName,
    required this.consumerEmail,
    required this.redeemedAt,
    required this.amount,
    required this.qrCode,
  });
}