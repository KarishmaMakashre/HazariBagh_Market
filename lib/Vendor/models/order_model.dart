class OrderModel {
  final String customer;
  final String orderId;
  final String amount;
  String status;

  OrderModel({
    required this.customer,
    required this.orderId,
    required this.amount,
    required this.status,
  });

  OrderModel copyWith({required String status}) {
    return OrderModel(
      orderId: orderId,
      customer: customer,
      amount: amount,
      status: status,
    );
  }
}
