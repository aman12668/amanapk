import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: AboutUs(),
  ));
}

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
       body: Stack(
       children: [
       Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/aboutbg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
      const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
                radius: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
              SizedBox(height: 20),
              Text(
                'We are a passionate team dedicated to delivering high-quality Education to our Students.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, ),
              ),
            ],
          ),
        ),
      ),
      ],
    ),
    );
    
  }
}
