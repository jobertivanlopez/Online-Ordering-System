import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/orderhistorymodel.dart'; // Make sure orderHistory is declared here

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key, required List<Order> orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order History")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Order History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            orderHistory.isNotEmpty
                ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: orderHistory.length,
              itemBuilder: (context, index) {
                final order = orderHistory[index];
                return _buildOrderCard(order);
              },
            )
                : Center(child: Text('No orders found.')),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 13),
      child: ListTile(
        title: Text('Order ID: ${order.orderId}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Method: ${order.orderMethod}'),
            Text('Amount: ₱${order.amount.toStringAsFixed(2)}'),
            Text('Status: ${order.status}'),
            Text('Placed: ${order.orderPlaced}'),
          ],
        ),
      ),
    );
  }
}
