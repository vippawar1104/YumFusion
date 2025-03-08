// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:foodapp/components/chat/chat_bot_screen.dart';
import 'package:foodapp/components/my_current_location.dart';
import 'package:foodapp/components/my_description_box.dart';
import 'package:foodapp/components/my_drawer.dart';
import 'package:foodapp/components/my_promo_banner.dart';
import 'package:foodapp/components/my_silver_app_bar.dart';
import 'package:foodapp/components/my_tab_bar.dart';
import 'package:foodapp/models/food.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/models/restaurant.dart';
import 'food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Helper Methods
  List<Food> _filterMenuByCategory(
      FoodCategory category, Restaurant restaurant) {
    switch (category) {
      case FoodCategory.burgers:
        return restaurant.menu;
      case FoodCategory.salads:
        return restaurant.saladmenu;
      case FoodCategory.drinks:
        return restaurant.drinksmenu;
      case FoodCategory.desserts:
        return restaurant.dessertsmenu;
      case FoodCategory.sides:
        return restaurant.sidesmenu;
    }
  }

  Widget _buildFoodItem(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodPage(food: food),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  food.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.restaurant, size: 50),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                food.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                food.description,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Text(
                '₹${food.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: const Text(
              "YumFusion",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [], // Removed order tracking action
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 8),
                MyCurrentLocation(),
                SizedBox(height: 8),
                MyDescriptionBox(),
                MyPromoBanner(),
              ],
            ),
          ),
        ],
        body: Consumer<Restaurant>(
          builder: (context, restaurant, child) {
            return Column(
              children: [
                MyTabBar(tabController: _tabController),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: FoodCategory.values.map((category) {
                      List<Food> categoryMenu =
                          _filterMenuByCategory(category, restaurant);

                      if (categoryMenu.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.no_meals,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No items available in ${category.name}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 16, bottom: 84),
                        itemCount: categoryMenu.length,
                        itemBuilder: (context, index) =>
                            _buildFoodItem(categoryMenu[index]),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "chat",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatBotScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFFFFA726),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
