import 'package:flutter/material.dart';
import '../models/orderhistorymodel.dart';
import '../globals.dart';

class OrderHistory extends StatelessWidget {
  final List<Order> orders;

  const OrderHistory({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          orders.isNotEmpty
              ? ListView.builder(
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
                  onTap: () => _showOrderDetailsModal(context, order),
                ),
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
    );
  }

  void _showOrderDetailsModal(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Details - ${order.orderId}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...order.dishes.map((dish) {
                final dishPrice = _getItemPrice(dish);  // Fetch price from the dishes list
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('$dish - ₱${dishPrice.toStringAsFixed(2)}'),
                );
              }).toList(),
              Divider(),
              Text('Total: ₱${order.amount.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the modal
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  double _getItemPrice(String itemName) {
    double price = 0.0;
    final dish = dishes.firstWhere((dish) => dish['name'] == itemName,
        orElse: () => {});
    if (dish.isNotEmpty) {
      price = double.tryParse(dish['price']?.substring(1) ?? '0') ?? 0.0;
    } else {
      final bilaoItem = bilao.firstWhere((bilao) => bilao['name'] == itemName,
          orElse: () => {});
      if (bilaoItem.isNotEmpty) {
        price = double.tryParse(bilaoItem['price']?.substring(1) ?? '0') ?? 0.0;
      } else {
        final dessertItem = desserts.firstWhere((dessert) =>
        dessert['name'] == itemName,
            orElse: () => {});
        if (dessertItem.isNotEmpty) {
          price = double.tryParse(dessertItem['price']?.substring(1) ?? '0') ?? 0.0;
        }
      }
    }
    return price;
  }
}
