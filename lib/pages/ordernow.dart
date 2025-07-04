import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Ordernow extends StatefulWidget {
  const Ordernow({super.key});

  @override
  State<Ordernow> createState() => _OrdernowState();
}

class _OrdernowState extends State<Ordernow> {
  String selectedCategory = 'Desserts';
  String deliveryOption = 'Delivery';

  final Map<String, int> quantities = {
    'Graham': 0,
    'Leche Plan': 0,
    'Graham Bar': 0,
    'Maja Blanca': 0,
  };

  final List<Map<String, String>> dishes = [
    {'name': 'Graham', 'price': '₱75.00', 'image': 'assets/images/Dessert.jpg'},
    {'name': 'Leche Plan', 'price': '₱75.00', 'image': 'assets/images/leche plan.jpg'},
    {'name': 'Graham Bar', 'price': '₱75.00', 'image': 'assets/images/Graham Bar.jpg'},
    {'name': 'Maja Blanca', 'price': '₱75.00', 'image': 'assets/images/maja.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFCA6C),
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 50),
          ],
        ),
        actions: isMobile
            ? [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(FontAwesomeIcons.bars, color: Colors.black),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ]
            : null,
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFFEFCA6C),
        width: 300,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            const SizedBox(height: 85),
            _drawerItem(context, 'Home', '/landingpage', FontAwesomeIcons.house),
            _drawerItem(context, 'Order Now', '/OrderNow', FontAwesomeIcons.cartPlus),
            _drawerItem(context, 'Contact Us', '/contactus', FontAwesomeIcons.phone),
            _drawerItem(context, 'Notifications', '/notifications', FontAwesomeIcons.bell),
            _drawerItem(context, 'Account', '/profile', FontAwesomeIcons.user),
            ListTile(
              leading: const Icon(FontAwesomeIcons.arrowRightFromBracket, color: Colors.black),
              title: const Text('Logout', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                _showLogoutModal(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['Dishes', 'Bilao', 'Desserts'].map((category) {
                  final isSelected = selectedCategory == category;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedCategory = category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEFCA6C) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
              child: GridView.count(
                crossAxisCount: isMobile ? 2 : 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.69,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: dishes.map((dish) {
                  final name = dish['name']!;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 1),
                        Image.asset(dish['image']!, height: 90, fit: BoxFit.cover),
                        const SizedBox(height: 8),
                        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(dish['price']!, style: const TextStyle(color: Colors.black54)),
                        const SizedBox(height: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.circleMinus, color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  if (quantities[name]! > 0) {
                                    quantities[name] = quantities[name]! - 1;
                                  }
                                });
                              },
                            ),
                            Text('${quantities[name]}'),
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.circlePlus, color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  quantities[name] = quantities[name]! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Opacity(
        opacity: 0.75,
        child: FloatingActionButton(
          onPressed: () => _showSummarySidebar(context),
          backgroundColor: const Color(0xFFEFCA6C),
          foregroundColor: Colors.black,
          child: const Icon(FontAwesomeIcons.receipt),
        ),
      ),
      floatingActionButtonLocation: const OffsetFloatingActionButtonLocation(
        xOffset: 30,
        yOffset: -200,
      ),
    );
  }

  void _checkout() {
    print('Proceeding to checkout...');
  }

  void _showSummarySidebar(BuildContext context) {
    final orderedItems = quantities.entries.where((e) => e.value > 0).toList();

    showDialog(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.centerRight,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Material(
            color: Colors.white,
            elevation: 13,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Orders',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    if (orderedItems.isEmpty)
                      const Text('No items selected.'),
                    if (orderedItems.isNotEmpty)
                      Expanded(
                        child: ListView(
                          children: orderedItems
                              .map((item) => ListTile(
                            title: Text(item.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                            trailing: Text('x${item.value}', style: const TextStyle(fontSize: 15)),
                          ))
                              .toList(),
                        ),
                      ),
                    if (orderedItems.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Total: ₱${orderedItems.fold(0.0, (total, item) {
                            final price = double.tryParse(
                              dishes.firstWhere((dish) => dish['name'] == item.key)['price']!.substring(1),
                            ) ??
                                0;
                            return total + (price * item.value);
                          }).toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    const SizedBox(height: 12),
                    const Text('Select Delivery Option:'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (deliveryOption == 'Delivery') {
                            deliveryOption = 'Pick Up';
                          } else if (deliveryOption == 'Pick Up') {
                            deliveryOption = 'Reservation';
                          } else {
                            deliveryOption = 'Delivery';
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEFCA6C),
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: Text(deliveryOption),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        _checkout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEFCA6C),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, String route, IconData icon) {
    return ListTile(
      leading: FaIcon(icon, color: Colors.black, size: 23),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  void _showLogoutModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFEFCA6C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.black),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}

class OffsetFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double xOffset;
  final double yOffset;

  const OffsetFloatingActionButtonLocation({
    this.xOffset = 0,
    this.yOffset = 0,
  });

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry geometry) {
    final fabSize = geometry.floatingActionButtonSize;
    final scaffoldSize = geometry.scaffoldSize;

    double x = scaffoldSize.width - fabSize.width - 16 + xOffset;
    double y = scaffoldSize.height - fabSize.height - 16 + yOffset;

    return Offset(x, y);
  }
}

