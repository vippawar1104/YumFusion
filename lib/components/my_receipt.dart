import 'package:flutter/material.dart';
import 'package:foodapp/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Thank you for your order!"),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: Consumer<Restaurant>(
                builder: (context, restaurant, child) {
                  return FutureBuilder<String>(
                    future: restaurant.displayCartReceipt(), // Use FutureBuilder to handle Future<String>
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show loading spinner
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Handle error
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text("No receipt available"); // If no data
                      } else {
                        return Text(snapshot.data!); // Show the receipt if data is available
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            const Text("Estimated delivery time is 4:10 PM"),
          ],
        ),
      ),
    );
  }
}