import 'package:flutter/material.dart';
import 'package:foodapp/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/themes/theme_provider.dart';

class MyCurrentLocation extends StatelessWidget {
  const MyCurrentLocation({super.key});

  void openLocationSearchBox(BuildContext context) {
    final bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    // Create a TextEditingController
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Your location",
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        content: TextField(
          controller: textController, // Add the controller here
          decoration: const InputDecoration(
            hintText: "Enter address...",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          // Cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
          // Save button
          MaterialButton(
            onPressed: () {
              // Get the new address from the controller
              String newAddress = textController.text.trim();
              
              // Only update if the address isn't empty
              if (newAddress.isNotEmpty) {
                // Update the address using Provider
                Provider.of<Restaurant>(context, listen: false)
                    .updateDeliveryAddress(newAddress);
                
                // Close the dialog
                Navigator.pop(context);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(
              color: isDarkMode 
                ? Colors.white 
                : Theme.of(context).colorScheme.primary
            ),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                // Address with expanded to prevent overflow
                Expanded(
                  child: Consumer<Restaurant>(
                    builder: (context, restaurant, child) => Text(
                      restaurant.deliveryAddress,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Dropdown menu
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: isDarkMode 
                    ? Colors.white 
                    : Theme.of(context).iconTheme.color,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}