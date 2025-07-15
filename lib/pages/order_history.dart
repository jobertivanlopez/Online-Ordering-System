import 'package:flutter/material.dart';
import 'package:online_ordering_system/models/orderhistorymodel.dart';
import '../globals.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key, required List<Order> orders});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            orderHistory.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderHistory.length,
              itemBuilder: (context, index) {
                final order = orderHistory[index];
                return _buildOrderCard(
                  order.orderId,
                  order.orderMethod,
                  order.orderPlaced,
                  '₱${order.amount.toStringAsFixed(2)}',
                  context,
                );
              },
            )
                : Center(
              child: Text(
                'No orders found.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual order cards
  Widget _buildOrderCard(String orderId, String orderMethod, String orderPlaced, String amount, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order ID: $orderId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text('Order Method: $orderMethod', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text('Order Placed: $orderPlaced', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Text('Amount: $amount', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
