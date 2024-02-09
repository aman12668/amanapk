import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

// Import navigation packages
import 'package:flutter/services.dart'; // For Navigator.pushNamed

class MenuScreenPage extends StatelessWidget {
  const MenuScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
          ),
          const SizedBox(height: 40),
          Container(
        
          ),
          const SizedBox(height: 40),
          Column(
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/home'),
                child: const Row(
                  children: [
                    Icon(Icons.home_outlined, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Home', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/class_10'),
                child: const Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Class 10', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              // ... (similar buttons for other routes)
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/logout'),
                child: const Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 10),
                    Text('Logout', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/AboutUs'),
                child: const Row(
                  children: [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 10),
                    Text('About Us', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
