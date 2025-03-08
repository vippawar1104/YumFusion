import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap; // Nullable callback

  const MyDrawerTile({
    super.key,
    required this.text,
    this.icon, // Icon is optional, so 'required' is not necessary
    this.onTap, // Nullable callback
  });

  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        onTap: onTap, // Attach the onTap callback
      ),
    );
  }
}
