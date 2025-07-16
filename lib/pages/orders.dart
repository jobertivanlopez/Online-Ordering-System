import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../globals.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            const Text(
              'Orders',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Check if there are orders in the global orders list
            orders.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
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
          // Order ID
          Text('Order ID: $orderId', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          // Order Method
          Text('Order Method: $orderMethod', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          // Order Placed
          Text('Order Placed: $orderPlaced', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          // Amount
          Text('Amount: $amount', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          // Row with action buttons: Track Order and View Order
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Track Order Button
              IconButton(
                icon: const Icon(FontAwesomeIcons.eye),
                onPressed: () => _showTrackOrderDialog(context),
                iconSize: 18,
              ),
              // View Order Icon
              IconButton(
                icon: const Icon(FontAwesomeIcons.receipt),
                onPressed: () {
                  // Navigate to the order details page or show more info
                  _showOrderDetails(context, orderId);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Track Order Dialog
  static void _showTrackOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Track Order", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Column(
                  children: [
                    Icon(FontAwesomeIcons.circleCheck, color: Colors.green, size: 24),
                    SizedBox(height: 24),
                    Icon(FontAwesomeIcons.circleCheck, color: Colors.green, size: 24),
                    SizedBox(height: 24),
                    Icon(FontAwesomeIcons.circleCheck, color: Colors.green, size: 24),
                  ],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Placed", style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 32),
                      Text("In Process", style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 32),
                      Text("Completed", style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: const [
                  Icon(FontAwesomeIcons.circleCheck, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("Your order has been completed"),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  // Order Detail Navigation
  void _showOrderDetails(BuildContext context, String orderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailPage(orderId: orderId), // Pass the order ID to the details page
      ),
    );
  }
}

// Order Detail Page
class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Details for Order ID: $orderId'),
          ],
        ),
      ),
    );
  }
}
