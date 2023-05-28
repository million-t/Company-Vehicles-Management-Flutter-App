import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff222831),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black, // Set the color of the app bar text
          ),
        ),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('Vehicles'),
              onTap: () {
                context.go('/settings/vehicles');
              },
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('Drivers'),
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('Edit profile'),
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('Theme'),
            ),
          ),
          Card(
            color: Colors.grey[300],
            child: ListTile(
              title: Text('About Us'),
            ),
          ),
        ],
      ),
    );
  }
}
