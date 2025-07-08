import 'package:flutter/material.dart';
import '../models/orderhistorymodel.dart';



class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the order from the arguments
    final Order order = ModalRoute.of(context)?.settings.arguments as Order;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.orderId}', style: TextStyle(fontSize: 20)),
            Text('Order Method: ${order.orderMethod}', style: TextStyle(fontSize: 18)),
            Text('Order Placed: ${order.orderPlaced}', style: TextStyle(fontSize: 18)),
            Text('Amount: ₱${order.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            Text('Status: ${order.status}', style: TextStyle(fontSize: 18, color: Colors.green)),
            const SizedBox(height: 20),
            Text('Ordered Items:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...order.dishes.map((dish) {
              return Text(dish, style: TextStyle(fontSize: 16));
            }).toList(),
            
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/OrderNow');
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD766),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Order Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}