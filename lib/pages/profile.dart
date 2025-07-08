import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/orderhistorymodel.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = orderHistory;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFCA6C),
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 50),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Display Order History
            if (orders.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order History',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Display each order in a ListTile
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
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
                      },
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
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
}