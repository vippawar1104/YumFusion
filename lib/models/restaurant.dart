import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'food.dart';

class Restaurant extends ChangeNotifier {
  // Firebase instances
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // burgers
  final List<Food> _menu = [
    Food(
      name: "Classic Chicken Burger",
      description:
          "A juicy grilled or crispy fried chicken patty seasoned to perfection, topped with fresh lettuce, ripe tomatoes, crunchy pickles, and a dollop of creamy mayo, all nestled between two soft and toasted burger buns. A timeless favorite for every burger lover!",
      imagePath: "lib/images/burgers/chicken_burger.png",
      price: 180,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra patty", price: 60),
        Addon(name: "Extra sauce", price: 20),
      ],
    ),
    Food(
      name: "BBQ Chicken Burger",
      description:
          "A succulent grilled or crispy chicken patty glazed with smoky barbecue sauce, topped with melted cheddar cheese, crispy onion rings, fresh lettuce, and tangy pickles. All stacked on a soft toasted bun with an extra drizzle of BBQ sauce for the perfect smoky and savory bite!",
      imagePath: "lib/images/burgers/BBQ_burger.png",
      price: 240,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra patty", price: 60),
        Addon(name: "Extra BBQ sauce", price: 20),
      ],
    ),
    Food(
      name: "Buffalo Chicken Burger",
      description:
          "A crispy fried or grilled chicken patty tossed in spicy Buffalo sauce, topped with cool ranch or blue cheese dressing, crisp lettuce, and sliced tomatoes. Served on a toasted bun for the perfect balance of heat and flavor in every bite!",
      imagePath: "lib/images/burgers/buffalo_chicken_burger.png",
      price: 260,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra patty", price: 60),
        Addon(name: "Extra ranch sauce", price: 20),
      ],
    ),
    Food(
      name: "Cheese Burger",
      description:
          "A juicy chicken patty topped with a slice of melted cheddar cheese, crisp lettuce, fresh tomatoes, and crunchy pickles, finished with a dollop of creamy mayo or ketchup. All stacked between two soft, toasted burger buns for a simple yet satisfying treat!",
      imagePath: "lib/images/burgers/cheese_burger.png",
      price: 180,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra patty", price: 60),
        Addon(name: "Extra sauce", price: 20),
      ],
    ),
    Food(
      name: "Veggie Burger",
      description:
          "A flavorful veggie patty made from wholesome ingredients like beans, lentils, or vegetables, seasoned with aromatic spices. Topped with fresh lettuce, juicy tomatoes, crunchy cucumbers, and a slice of melted cheese (optional), with a dollop of creamy mayo or tangy ketchup. Served on a soft, toasted bun for a delicious plant-based delight!",
      imagePath: "lib/images/burgers/veggie_burger.png",
      price: 150,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra patty", price: 60),
        Addon(name: "Extra sauce", price: 20),
      ],
    ),
  ];
  // salads
  // ignore: unused_field
  final List<Food> _saladmenu = [
    Food(
      name: "Asian Sesame Salad",
      description:
          "A refreshing mix of crisp romaine lettuce, shredded cabbage, julienned carrots, and sliced cucumbers, tossed with crunchy sesame seeds, crispy wonton strips, and a tangy sesame ginger dressing. Garnished with fresh cilantro and scallions for an extra burst of flavor. Perfect as a light meal or a side dish!",
      imagePath: "lib/images/salads/asiansesame_salad.png",
      price: 210,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra lettuce", price: 30),
        Addon(name: "Extra sesame", price: 60),
        Addon(name: "Extra dressing", price: 20),
      ],
    ),
    Food(
      name: "Caesar Salad",
      description:
          "A classic salad featuring crisp romaine lettuce tossed in a creamy Caesar dressing, topped with crunchy croutons and freshly grated Parmesan cheese. Finished with a sprinkle of black pepper and a hint of lemon for a tangy, savory flavor in every bite. Simple, yet utterly satisfying!",
      imagePath: "lib/images/salads/caesar_salad.png",
      price: 230,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra chicken", price: 60),
        Addon(name: "Extra dressing", price: 20),
      ],
    ),
    Food(
      name: "Greek Salad",
      description:
          "A vibrant mix of ripe tomatoes, crisp cucumbers, red onions, Kalamata olives, and creamy feta cheese, all tossed together with a drizzle of extra virgin olive oil and a splash of red wine vinegar. Finished with a sprinkle of oregano and black pepper for an authentic Mediterranean flavor in every bite!",
      imagePath: "lib/images/salads/greek_salad.png",
      price: 200,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra feta", price: 60),
        Addon(name: "Extra dressing", price: 20),
      ],
    ),
    Food(
      name: "Cobb Salad",
      description:
          "A hearty and colorful salad featuring a base of crisp lettuce, topped with rows of diced chicken breast, crispy bacon, hard-boiled eggs, ripe avocado, cherry tomatoes, blue cheese crumbles, and red onions. Drizzled with your choice of dressing, this salad offers a perfect balance of fresh, savory, and creamy flavors in every bite!",
      imagePath: "lib/images/salads/Cobb_salad.png",
      price: 270,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra chicken", price: 60),
        Addon(name: "Extra dressing", price: 20),
      ],
    ),
    Food(
      name: "Caprese Salad",
      description:
          "A simple yet elegant Italian salad made with fresh, ripe tomatoes, creamy mozzarella cheese, and fragrant basil leaves. Drizzled with extra virgin olive oil and balsamic glaze, and sprinkled with a pinch of sea salt and black pepper. Light, refreshing, and bursting with classic Mediterranean flavors!",
      imagePath: "lib/images/salads/Caprese_salad.png",
      price: 220,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra mozarella", price: 60),
        Addon(name: "Extra dressing", price: 20),
      ],
    ),
  ];
  // ignore: unused_field
  final List<Food> _drinksmenu = [
    //drinks
    Food(
      name: "Mint Mojito(ice)",
      description:
          "A refreshing and invigorating cocktail made with fresh mint leaves, lime juice, and a touch of sugar, muddled together to release vibrant flavors. Topped with sparkling soda water and crushed ice, this drink is garnished with extra mint sprigs and a lime wedge for a cooling, zesty experience. Perfect for hot days or any time you need a revitalizing treat!",
      imagePath: "lib/images/drinks/mint_mojito_ice.png",
      price: 160,
      category: FoodCategory.drinks,
      availableAddons: [
Addon(name: "Extra mint", price: 10),
      Addon(name: "Extra lime", price: 5),
      Addon(name: "Extra sugar", price: 5),
      ],
    ),
    Food(
      name: "banana shake",
      description:
          "A creamy and smooth blend of ripe bananas, cold milk, and a touch of vanilla, sweetened to perfection. This delicious shake is topped with whipped cream (optional) and a sprinkle of cinnamon or nutmeg for extra flavor. A refreshing, naturally sweet treat that’s both indulgent and wholesome!",
      imagePath: "lib/images/drinks/banana_shake.png",
      price: 130,
      category: FoodCategory.drinks,
      availableAddons: [
      Addon(name: "Extra whipped cream", price: 15),
      Addon(name: "Extra banana", price: 10),
      Addon(name: "Extra vanilla", price: 5),
      ],
    ),
    Food(
      name: "Strawberry Shake",
      description:
          "A creamy, refreshing blend of fresh strawberries, chilled milk, and a touch of vanilla, creating a perfectly smooth and sweet treat. Topped with whipped cream and a few extra strawberry slices for added flavor and garnish. This delightful shake is the perfect balance of fruity and creamy goodness!",
      imagePath: "lib/images/drinks/strawberry_shake.png",
      price: 150,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra whipped cream", price: 15),
        Addon(name: "Extra strawberry", price: 10),
        Addon(name: "Extra vanilla", price: 5),
      ],
    ),
    Food(
      name: "Ice Tea Cocktail",
      description:
          "A refreshing blend of chilled iced tea, mixed with a splash of your favorite spirits, such as vodka, rum, or gin. Enhanced with a hint of citrus juice (like lemon or lime), a touch of honey or simple syrup for sweetness, and garnished with fresh mint leaves and fruit slices. This cocktail is the perfect balance of sweet, tangy, and herbal flavors—ideal for a relaxing summer evening!",
      imagePath: "lib/images/drinks/ice_tea_cocktail.png",
      price: 210,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra citrus", price: 5),
        Addon(name: "Extra mint", price: 10),
        Addon(name: "Extra honey", price: 5),
      ],
    ),
    Food(
      name: "Virgin Pina Colada",
      description:
          "A tropical, non-alcoholic delight made with creamy coconut milk, sweet pineapple juice, and crushed ice, blended to smooth perfection. Garnished with a pineapple slice and a maraschino cherry for that classic island feel. This refreshing drink offers a sweet and creamy escape to paradise in every sip!",
      imagePath: "lib/images/drinks/Pina_colada.png",
      price: 180,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "Extra pineapple", price: 10),
        Addon(name: "Extra coconut", price: 5),
        Addon(name: "Extra ice", price: 5),
      ],
    ),
  ];
  // ignore: unused_field
  final List<Food> _dessertsmenu = [
    //desserts
    Food(
      name: "Tiramisu",
      description:
          "Indulge in the classic Italian dessert, Tiramisu, that is guaranteed to satisfy your sweet cravings. Layers of espresso-soaked ladyfingers are paired with a creamy, rich mascarpone filling, creating a delicate balance of sweetness and coffee flavor. Topped with a dusting of cocoa powder, this dessert is the perfect way to end any meal. Whether you are a fan of coffee or just love indulgent treats, Tiramisu brings a taste of Italy to your doorstep.",
      imagePath: "lib/images/desserts/tiramisu.png",
      price: 150,
      category: FoodCategory.desserts,
      availableAddons: [
              Addon(name: "Extra cocoa powder", price: 10),
      Addon(name: "Extra coffee", price: 15),
      Addon(name: "Whipped cream", price: 15),
      ],
    ),
    Food(
      name: "Black Forest Pastries",
      description:
          "A rich and decadent dessert made with layers of moist chocolate cake, sweetened whipped cream, and dark cherries. Each slice is generously filled with a rich cherry filling and topped with chocolate shavings and more cherries. This indulgent treat combines the perfect balance of chocolate, cream, and fruit, making it a delightful choice for any occasion.",
      imagePath: "lib/images/desserts/black_forest.png",
      price: 190,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra berries", price: 20),
      Addon(name: "Whipped cream", price: 15),
      Addon(name: "Chocolate sauce", price: 25),
      ],
    ),
    Food(
      name: "Red Velvet Pastries",
      description:
          "Indulge in the luxurious taste of our Red Velvet Pastries, a dessert that’s as stunning as it is delicious. These vibrant, ruby-red pastries are soft, moist, and perfectly balanced with a subtle hint of cocoa.",
      imagePath: "lib/images/desserts/red_velvet_pastries.png",
      price: 220,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra berries", price: 20),
      Addon(name: "Whipped cream", price: 15),
      Addon(name: "Red velvet sauce", price: 25),
      ],
    ),
    Food(
      name: "Chocolate Lava Cake",
      description:
          "A warm, indulgent dessert with a rich, gooey chocolate center that flows out when you cut into it. The outer layer is soft and slightly crisp, made from a blend of dark chocolate and butter. Often served with a scoop of vanilla ice cream or a dollop of whipped cream, this molten cake is the ultimate chocolate lover’s treat!",
      imagePath: "lib/images/desserts/chocolate_lava_cake.png",
      price: 240,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "Extra ice cream", price: 30),
      Addon(name: "Extra chocolate sauce", price: 20),
      Addon(name: "Whipped cream", price: 15),
      ],
    ),
    Food(
      name: "Brownies",
      description:
          "Indulge in our decadently rich brownies, baked to perfection with premium chocolate for a melt-in-your-mouth experience. Whether you love them gooey or slightly crisp on the edges, our brownies are the ultimate comfort dessert.",
      imagePath: "lib/images/desserts/brownies.png",
      price: 210,
      category: FoodCategory.desserts,
      availableAddons: [
         Addon(name: "Extra ice cream", price: 30),
      Addon(name: "Extra chocolate sauce", price: 20),
      Addon(name: "Whipped cream", price: 15),
      ],
    ),
  ];
  // ignore: unused_field
  final List<Food> _sidesmenu = [
    //sides
    Food(
      name: "French Fries",
      description:
          "Crispy on the outside and soft on the inside, French fries are golden, thinly sliced potatoes fried to perfection. Served hot and sprinkled with a pinch of salt, they make the perfect side dish or snack. Often enjoyed with a variety of dips, like ketchup, mayo, or cheese sauce, French fries are a classic comfort food loved by all!",
      imagePath: "lib/images/sides/french_fries_side.png",
      price: 120,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra fries", price: 60),
        Addon(name: "Extra sauce", price: 20),
      ],
    ),
    Food(
      name: "Garlic Bread",
      description:
          "A deliciously crispy and buttery bread, generously spread with a flavorful mixture of minced garlic, butter, and herbs like parsley. Toasted to golden perfection, garlic bread is the perfect side dish to complement pasta, soups, or salads, offering a savory, aromatic taste with every bite.",
      imagePath: "lib/images/sides/garlic_bread_side.png",
      price: 150,
      category: FoodCategory.sides,
      availableAddons: [
   
      Addon(name: "Extra garlic", price: 15),
      Addon(name: "Cheese", price: 20),
      Addon(name: "Olive oil drizzle", price: 10),
      ],
    ),
    Food(
      name: "Pasta",
      description:
          "Savor the comfort of perfectly cooked pasta, served in a variety of delicious sauces. From the rich, creamy Alfredo to the tangy, herby Marinara, each bite of our pasta is a delightful journey of flavors. Whether you prefer classic Spaghetti, hearty Penne, or delicate Fettuccine, our pasta is made with the finest ingredients and cooked to perfection. Topped with fresh herbs, grated cheese, and a sprinkle of love, it’s the ultimate comfort food, delivered right to your door. Perfect for any craving, anytime.",
      imagePath: "lib/images/sides/pasta.png",
      price: 130,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra white sauce", price: 60),
        Addon(name: "Extra tomato sauce", price: 20),
      ],
    ),
    Food(
      name: "Onion Rings",
      description:
          "Crispy, golden-brown rings of sliced onions, coated in a seasoned batter and deep-fried to perfection. The outer layer is crunchy and flavorful, while the inside stays soft and sweet. Often served as a side dish or appetizer, onion rings are perfect with dipping sauces like ketchup, ranch, or barbecue sauce for an extra burst of flavor.",
      imagePath: "lib/images/sides/Onion_rings.png",
      price: 170,
      category: FoodCategory.sides,
      availableAddons: [
         Addon(name: "Extra sauce", price: 20),
      Addon(name: "Extra cheese", price: 30),
      Addon(name: "Extra crispy", price: 15),
      ],
    ),
    Food(
      name: "Mozzarella Sticks",
      description:
          "Golden, crispy-coated sticks filled with melted mozzarella cheese. These cheesy treats are deep-fried to perfection, offering a crunchy exterior and a gooey, stretchy interior. Often served with a side of marinara sauce or ranch for dipping, mozzarella sticks make for a savory appetizer or snack that’s sure to satisfy your cravings!",
      imagePath: "lib/images/sides/Mozzarella_Sticks_side.png",
      price: 210,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra cheese", price: 30),
        Addon(name: "Extra sticks", price: 60),
        Addon(name: "Extra sauce", price: 20),
      ],
    ),
  ];
  // user cart
  final List<CartItem> _cart = [];

  // delivery address with Firebase integration
  String _deliveryAddress = 'Loading address...';

  // Constructor
  Restaurant() {
    _loadDeliveryAddress();
  }

  // Load address from Firestore
  Future<void> _loadDeliveryAddress() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        final doc = await _firestore.collection('users').doc(userId).get();

        if (doc.exists && doc.data()!.containsKey('deliveryAddress')) {
          _deliveryAddress = doc.data()!['deliveryAddress'];
          notifyListeners();
        } else {
          // Set a default address if none exists
          _deliveryAddress = 'No address set';
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error loading delivery address: $e');
      _deliveryAddress = 'Error loading address';
      notifyListeners();
    }
  }

  // GETTERS
  List<Food> get menu => _menu;
  List<Food> get saladmenu => _saladmenu;
  List<Food> get drinksmenu => _drinksmenu;
  List<Food> get dessertsmenu => _dessertsmenu;
  List<Food> get sidesmenu => _sidesmenu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  // CART OPERATIONS
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      final index = cart.indexOf(cartItem);
      cart[index] = CartItem(
        food: cartItem.food,
        selectedAddons: cartItem.selectedAddons,
        quantity: cartItem.quantity - 1,
      );
    } else {
      cart.remove(cartItem);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  int getTotalItemCount() {
    return _cart.fold(0, (total, item) => total + item.quantity);
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Update delivery address with Firebase
  Future<void> updateDeliveryAddress(String newAddress) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId != null) {
        // Update Firestore
        await _firestore.collection('users').doc(userId).set({
          'deliveryAddress': newAddress,
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        // Update local state
        _deliveryAddress = newAddress;
        notifyListeners();
      } else {
        throw Exception('User not logged in');
      }
    } catch (e) {
      print('Error updating delivery address: $e');
      throw Exception('Failed to update delivery address');
    }
  }

  // Generate and save receipt to Firestore
  Future<String> displayCartReceipt() async {
    final StringBuffer receipt = StringBuffer();
    final userId = _auth.currentUser?.uid;

    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    // Save receipt to Firestore
    if (userId != null) {
      try {
        final receiptData = {
          'timestamp': FieldValue.serverTimestamp(),
          'items': _cart
              .map((item) => {
                    'name': item.food.name,
                    'quantity': item.quantity,
                    'price': item.food.price,
                    'addons': item.selectedAddons
                        .map((addon) => {
                              'name': addon.name,
                              'price': addon.price,
                            })
                        .toList(),
                  })
              .toList(),
          'totalPrice': getTotalPrice(),
          'deliveryAddress': _deliveryAddress,
          'userId': userId,
        };

        await _firestore.collection('receipts').add(receiptData);
      } catch (e) {
        print('Error saving receipt to Firestore: $e');
      }
    }

    // Format receipt
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("----------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("     Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("-----------");
    receipt.writeln();
    receipt.writeln("Total Items:  ${getTotalItemCount().toString()}");
    receipt.writeln("Total Price:  ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $_deliveryAddress");

    return receipt.toString();
  }

  // Helper methods
  String _formatPrice(double price) {
    return "\₹${price.toStringAsFixed(2)}";
  }

  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }

  static double getAddonPrice(List<Addon> addons) {
    return addons.fold(0, (sum, addon) => sum + addon.price);
  }
}

class CartItem {
  final Food food;
  final List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });
}
