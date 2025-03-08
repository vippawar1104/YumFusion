// lib/components/chat/chat_bot_screen.dart

import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? quickReplies;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.quickReplies,
  });
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  // ignore: unused_field
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _sendWelcomeMessage();
  }

  void _sendWelcomeMessage() {
    _addBotMessage(
      "Hello! 👋 I'm Yumi, your food assistant. How can I help you today?",
      quickReplies: [
        "Menu Recommendations",
        "Burgers",
        "Salads",
        "Drinks",
        "Desserts",
      ],
    );
  }

  void _addBotMessage(String text, {List<String>? quickReplies}) {
    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(Message(
            text: text,
            isUser: false,
            timestamp: DateTime.now(),
            quickReplies: quickReplies,
          ));
          _isTyping = false;
        });
        _scrollToBottom();
      }
    });
  }

  void _handleUserMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _controller.clear();
    });
    _scrollToBottom();

    _processUserMessage(text.toLowerCase());
  }

  void _processUserMessage(String text) {
    final menuItems = {
      "burgers": [
        "Classic Chicken",
        "BBQ Chicken",
        "Buffalo Chicken",
        "Cheese Burger",
        "Veggie Burger"
      ],
      "salads": ["Asian Sesame", "Caesar", "Greek", "Cobb", "Caprese"],
      "drinks": [
        "Mint Mojito",
        "Banana Shake",
        "Strawberry Shake",
        "Ice Tea",
        "Virgin Pina Colada"
      ],
      "desserts": [
        "Tiramisu",
        "Black Forest",
        "Red Velvet",
        "Chocolate Lava Cake",
        "Brownies"
      ],
      "sides": [
        "French Fries",
        "Garlic Bread",
        "Pasta",
        "Onion Rings",
        "Mozzarella Sticks"
      ]
    };

    final menuDescriptions = {
      "burgers": {
        "Classic Chicken":
            "Juicy grilled chicken patty with fresh lettuce and mayo",
        "BBQ Chicken": "Tender chicken with tangy BBQ sauce and crispy onions",
        "Buffalo Chicken":
            "Spicy buffalo-style chicken with cool ranch dressing",
        "Cheese Burger":
            "Classic beef patty with melted cheese and special sauce",
        "Veggie Burger":
            "Plant-based patty with fresh vegetables and vegan mayo"
      },
      "salads": {
        "Asian Sesame": "Mixed greens with sesame dressing and crispy noodles",
        "Caesar":
            "Romaine lettuce, croutons, parmesan, classic Caesar dressing",
        "Greek":
            "Tomatoes, cucumbers, olives, feta cheese with Greek vinaigrette",
        "Cobb": "Grilled chicken, bacon, eggs, avocado on mixed greens",
        "Caprese": "Fresh mozzarella, tomatoes, basil with balsamic glaze"
      },
      "drinks": {
        "Mint Mojito": "Refreshing non-alcoholic mint and lime mocktail",
        "Banana Shake": "Creamy banana smoothie with vanilla ice cream",
        "Strawberry Shake": "Fresh strawberry blend with whipped cream",
        "Ice Tea": "Chilled tea with lemon and mint",
        "Virgin Pina Colada": "Tropical coconut and pineapple blend"
      },
      "desserts": {
        "Tiramisu": "Classic Italian coffee-flavored dessert",
        "Black Forest": "Chocolate cake with cherries and whipped cream",
        "Red Velvet": "Rich red chocolate cake with cream cheese frosting",
        "Chocolate Lava Cake":
            "Warm chocolate cake with molten chocolate center",
        "Brownies": "Rich, fudgy chocolate brownies"
      },
      "sides": {
        "French Fries": "Crispy golden potato fries",
        "Garlic Bread": "Toasted bread with garlic butter",
        "Pasta": "Chef's special pasta with choice of sauce",
        "Onion Rings": "Crispy battered onion rings",
        "Mozzarella Sticks": "Breaded and fried cheese sticks"
      }
    };
    final nutritionInfo = {
      "burgers": {
        "Classic Chicken": "450 cal | 22g protein | 12g fat",
        "BBQ Chicken": "520 cal | 24g protein | 15g fat",
        "Buffalo Chicken": "480 cal | 23g protein | 14g fat",
        "Cheese Burger": "650 cal | 28g protein | 32g fat",
        "Veggie Burger": "380 cal | 18g protein | 8g fat"
      },
      "salads": {
        "Asian Sesame": "320 cal | 12g protein | 18g fat",
        "Caesar": "380 cal | 14g protein | 22g fat",
        "Greek": "290 cal | 8g protein | 16g fat",
        "Cobb": "520 cal | 32g protein | 28g fat",
        "Caprese": "280 cal | 12g protein | 16g fat"
      },
      "drinks": {
        "Mint Mojito": "120 cal | 0g protein | 0g fat | 28g sugar",
        "Banana Shake": "380 cal | 8g protein | 12g fat | 45g sugar",
        "Strawberry Shake": "340 cal | 7g protein | 11g fat | 42g sugar",
        "Ice Tea": "80 cal | 0g protein | 0g fat | 18g sugar",
        "Virgin Pina Colada": "260 cal | 2g protein | 6g fat | 38g sugar"
      },
      "desserts": {
        "Tiramisu": "420 cal | 6g protein | 24g fat | 35g sugar",
        "Black Forest": "480 cal | 5g protein | 22g fat | 42g sugar",
        "Red Velvet": "450 cal | 5g protein | 20g fat | 40g sugar",
        "Chocolate Lava Cake": "520 cal | 7g protein | 28g fat | 45g sugar",
        "Brownies": "380 cal | 4g protein | 18g fat | 32g sugar"
      },
      "sides": {
        "French Fries": "320 cal | 4g protein | 16g fat | 2g sugar",
        "Garlic Bread": "240 cal | 6g protein | 12g fat | 2g sugar",
        "Pasta": "380 cal | 12g protein | 8g fat | 4g sugar",
        "Onion Rings": "280 cal | 3g protein | 14g fat | 3g sugar",
        "Mozzarella Sticks": "420 cal | 16g protein | 22g fat | 2g sugar"
      }
    };

    final allergenInfo = {
      "burgers": {
        "Classic Chicken": ["gluten", "eggs"],
        "BBQ Chicken": ["gluten", "soy"],
        "Buffalo Chicken": ["gluten", "dairy"],
        "Cheese Burger": ["gluten", "dairy"],
        "Veggie Burger": ["gluten", "soy"]
      },
      "salads": {
        "Asian Sesame": ["soy", "nuts"],
        "Caesar": ["gluten", "dairy", "eggs"],
        "Greek": ["dairy"],
        "Cobb": ["dairy", "eggs"],
        "Caprese": ["dairy"]
      }
    };

    final popularCombos = {
      "Lunch Special": ["Classic Chicken", "French Fries", "Ice Tea"],
      "Veggie Delight": ["Veggie Burger", "Greek Salad", "Mint Mojito"],
      "Party Pack": ["BBQ Chicken", "Onion Rings", "Chocolate Lava Cake"],
      "Health Boost": ["Cobb Salad", "Banana Shake", "Fresh Fruit"]
    };

    void generateMenuResponse(String category) {
      String menuList = menuItems[category]!.map((item) {
        return "• $item: ${menuDescriptions[category]![item]}";
      }).join("\n");

      _addBotMessage("Here are our available $category:\n\n$menuList",
          quickReplies: [
            "Nutrition Info",
            "Allergens",
            "Popular Combos",
            "Order Now"
          ]);
    }

    void handleNutritionQuery(String item) {
      for (var category in nutritionInfo.keys) {
        if (nutritionInfo[category]!.containsKey(item)) {
          _addBotMessage(
              "Nutrition information for $item:\n${nutritionInfo[category]![item]}",
              quickReplies: ["View Allergens", "Back to Menu", "Order Now"]);
          return;
        }
      }
    }

    // ignore: unused_element
    void handleAllergenQuery(String item) {
      for (var category in allergenInfo.keys) {
        if (allergenInfo[category]!.containsKey(item)) {
          String allergens = allergenInfo[category]![item]!.join(", ");
          _addBotMessage(
              "Allergen information for $item:\nContains: $allergens",
              quickReplies: ["View Nutrition", "Back to Menu", "Order Now"]);
          return;
        }
      }
    }

    text = text.toLowerCase();

    // Handle specific menu queries
    if (text.contains("burger") || text.contains("burgers")) {
      generateMenuResponse("burgers");
    } else if (text.contains("salad") || text.contains("salads")) {
      generateMenuResponse("salads");
    } else if (text.contains("drink") || text.contains("drinks")) {
      generateMenuResponse("drinks");
    } else if (text.contains("dessert") || text.contains("desserts")) {
      generateMenuResponse("desserts");
    } else if (text.contains("side") || text.contains("sides")) {
      generateMenuResponse("sides");
    } // Handle nutrition queries
    else if (text.contains("nutrition") ||
        text.contains("calories") ||
        text.contains("protein")) {
      if (text.contains("chicken")) {
        handleNutritionQuery("Classic Chicken");
      } else {
        _addBotMessage(
            "I can provide nutrition information for any menu item. Which item would you like to know about?",
            quickReplies: [
              "Classic Chicken",
              "BBQ Chicken",
              "Veggie Burger",
              "Cobb Salad"
            ]);
      }
    }
    // Handle allergen queries
    else if (text.contains("allerg") ||
        text.contains("gluten") ||
        text.contains("dairy")) {
      _addBotMessage(
          "I can provide allergen information for any menu item. Which item would you like to know about?",
          quickReplies: [
            "Classic Chicken",
            "Veggie Burger",
            "Caesar Salad",
            "Greek Salad"
          ]);
    }
    // Handle combo queries
    else if (text.contains("combo") ||
        text.contains("deal") ||
        text.contains("special")) {
      String comboList = popularCombos.entries.map((combo) {
        return "• ${combo.key}: ${combo.value.join(" + ")}";
      }).join("\n");

      _addBotMessage("Here are our popular combinations:\n\n$comboList",
          quickReplies: ["Order Combo", "Custom Order", "View Menu"]);
    }
    // Handle ordering queries
    else if (text.contains("order") ||
        text.contains("buy") ||
        text.contains("get")) {
      _addBotMessage(
          "Great! Would you like to:\n"
          "• Order a popular combo\n"
          "• Create a custom order\n"
          "• View our full menu",
          quickReplies: ["Popular Combos", "Custom Order", "View Menu"]);
    }
    // Handle pricing queries
    else if (text.contains("price") ||
        text.contains("cost") ||
        text.contains("how much")) {
      _addBotMessage(
          "I can help you with pricing information. What would you like to know about?",
          quickReplies: ["Burgers", "Salads", "Drinks", "Combos"]);
    }
    // Handle dietary restriction queries
    else if (text.contains("vegan") ||
        text.contains("vegetarian") ||
        text.contains("gluten-free")) {
      _addBotMessage(
          "We have several options for dietary restrictions. Would you like to see our:\n"
          "• Vegetarian/Vegan options\n"
          "• Gluten-free options\n"
          "• Low-calorie options",
          quickReplies: [
            "Vegetarian Options",
            "Gluten-free Options",
            "Low-calorie Options"
          ]);
    }
    // Handle general questions
    else if (text.contains("hour") ||
        text.contains("open") ||
        text.contains("close")) {
      _addBotMessage(
          "We're open daily from 11:00 AM to 10:00 PM.\nKitchen closes at 9:30 PM.",
          quickReplies: ["View Menu", "Place Order", "Location"]);
    }
    // Default response
    else {
      _addBotMessage(
          "I can help you with:\n"
          "• Menu recommendations\n"
          "• Nutrition information\n"
          "• Allergen information\n"
          "• Popular combos\n"
          "• Placing orders\n"
          "• Hours and location",
          quickReplies: [
            "View Menu",
            "Nutrition Info",
            "Popular Combos",
            "Place Order"
          ]);
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yumi')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          ChatInput(controller: _controller, onSubmitted: _handleUserMessage),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: message.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser ? Color(0xFFFFA726) : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const ChatInput(
      {Key? key, required this.controller, required this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 3,
        )
      ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Color(0xFFFFA726),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => onSubmitted(controller.text),
            ),
          ),
        ],
      ),
    );
  }
}
