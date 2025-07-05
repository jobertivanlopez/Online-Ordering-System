import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Ordernow extends StatefulWidget {
  const Ordernow({super.key});

  @override
  State<Ordernow> createState() => _OrdernowState();
}

class _OrdernowState extends State<Ordernow> with TickerProviderStateMixin {
  String selectedCategory = 'Dishes';
  String deliveryOption = 'Delivery';
  final Map<String, int> quantities = {
    'Lomi': 0,
    'Sweet & Spicy': 0,
    'Plain': 0,
    'Bihon': 0,
    'Tapsilog': 0,
    'Hotsilog': 0,
    'Pancit Bilao': 0,
    'Spaghetti Bilao': 0,
    'Palabok Bilao': 0,
    'Chami Bilao': 0,
  };

  final List<Map<String, String>> dishes = [
    {'name': 'Lomi', 'price': '₱75.00', 'image': 'assets/images/lomi.jpg'},
    {'name': 'Sweet & Spicy', 'price': '₱75.00', 'image': 'assets/images/sweet_and_spicy.png'},
    {'name': 'Plain', 'price': '₱75.00', 'image': 'assets/images/plain.png'},
    {'name': 'Bihon', 'price': '₱75.00', 'image': 'assets/images/Pancit_Canton_Bihon_Guisado.png'},
    {'name': 'Tapsilog', 'price': '₱75.00', 'image': 'assets/images/tapsilog.png'},
    {'name': 'Hotsilog', 'price': '₱75.00', 'image': 'assets/images/hotsilog.png'},
  ];


  final List<Map<String, String>> bilao = [
    {
      'name': 'Pancit Bilao',
      'price': '₱250.00',
      'image': 'assets/images/Pancit_Canton_Bihon_Guisado.png',
    },
    {
      'name': 'Spaghetti Bilao',
      'price': '₱280.00',
      'image': 'assets/images/Spaghetti.png',

    },
    {
      'name': 'Palabok Bilao',
      'price': '₱300.00',
      'image': 'assets/images/palabok_bilao.png',

    },
    {
      'name': 'Chami Bilao',
      'price': '₱270.00',
      'image': 'assets/images/chami_bilao.png',
    },
  ];


  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetAnimation() {
    _controller.reset();
    _controller.forward();
  }

  void _reverseAnimation() {
    _controller.reverse();
  }



  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      // backgroundColor: Colors.white,
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
        width: 200,
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

            // Category Tabs
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

            selectedCategory == 'Dishes'
                ? _buildDishesGrid(isMobile)  //show the Dishes Grid when selected
                : selectedCategory == 'Bilao'
                ? _buildBilaoGrid(isMobile)  // show the Bilao Grid when selected
                : Container(),  // desserts empty for now
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

  Widget _buildDishesGrid(bool isMobile) {
    return Padding(
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
    );
  }

  Widget _buildBilaoGrid(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: GridView.count(
        crossAxisCount: isMobile ? 2 : 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: bilao.map((dish) {
          final name = dish['name']!;
          final price = dish['price']!;
          final image = dish['image']!;
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
                Image.asset(image, height: 80, fit: BoxFit.cover),
                const SizedBox(height: 8),
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.circleMinus, color: Colors.black,),
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
                      icon: const FaIcon(FontAwesomeIcons.circlePlus, color: Colors.black,),
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
    );
  }



  //Checkout modal
  void _checkout() {
    if (_hashItems()) {
      _showCheckoutModal();
    } else {
      // Close the sidebar if it's open
      Navigator.pop(context);

      _showCustomSnackBar('Please add items to your order.');
    }
  }

  void _showCustomSnackBar(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 45),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 5), () {
      overlayEntry.remove();
    });
  }


  bool _hashItems(){
    return quantities.values.any((quantity) => quantity > 0);
  }

  void _showCheckoutModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 23,),
                margin: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFEFCA6C)
                ),
              ),
              if (deliveryOption == 'Delivery')
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Enter Delivery Address',
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEFCA6C)),
                child: const Text('Cancel', style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                onPressed: _hashItems() ? () {
                  Navigator.pop(context); // Close the modal
                } : null,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFEFCA6C)),
                child: const Text('Place Order', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSummarySidebar(BuildContext context) {
    final orderedItems = quantities.entries.where((e) => e.value > 0).toList();

    _resetAnimation();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Align(
              alignment: Alignment.centerRight,
              child: SlideTransition(
                position: _slideAnimation,
                child: FractionallySizedBox(
                  alignment: Alignment.centerRight,
                  widthFactor: 1.0,
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
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                iconSize: 30,
                                onPressed: () {
                                  _reverseAnimation();
                                  Future.delayed(const Duration(milliseconds: 250), () {
                                    Navigator.pop(context); // Close the sidebar
                                  });
                                },
                              ),
                            ),
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
                                    title: Text(item.key,
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    trailing: Text('x${item.value}',
                                        style: const TextStyle(fontSize: 15)),
                                  ))
                                      .toList(),
                                ),
                              ),
                            // Total price section
                            if (orderedItems.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                  'Total: ₱${orderedItems.fold(0.0, (total, item) {
                                    double price = 0.0;

                                    final dish = dishes.firstWhere(
                                          (dish) => dish['name'] == item.key,
                                      orElse: () => {},
                                    );
                                    if (dish.isNotEmpty) {
                                      price = double.tryParse(dish['price']?.substring(1) ?? '0') ?? 0.0;
                                    } else {
                                      final bilaoItem = bilao.firstWhere(
                                            (bilao) => bilao['name'] == item.key,
                                        orElse: () => {},
                                      );
                                      if (bilaoItem.isNotEmpty) {
                                        price =
                                            double.tryParse(bilaoItem['price']?.substring(1) ?? '0') ?? 0.0;
                                      }
                                    }

                                    return total + (price * item.value);
                                  }).toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            const SizedBox(height: 12),
                            Text('Select Delivery Option:'),
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
          },
        );
      },
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
