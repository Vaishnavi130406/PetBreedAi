import 'package:flutter/material.dart';
import 'encyclopedia.dart';
import 'chatbot_page.dart';
import 'smart_match.dart';
import 'facts_page.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color backgroundColor = Color(0xFFFDF6EC);
  static const Color primary = Color(0xFFF4A261);
  static const Color green = Color(0xFF2A9D8F);
  static const Color brown = Color(0xFF5D4037);
 
  /// ✅ ALL 35 PETS ADDED
  final List<Map<String, String>> pets = [
    // 🐶 Dogs
    {"name": "Maxi", "breed": "Bulldog", "image": "assets/Bulldog.jpg"},
    {"name": "Rocky", "breed": "Labrador", "image": "assets/Labrador.jpg"},
    {"name": "Luna", "breed": "German Shepherd", "image": "assets/German Shepherd.jpg"},
    {"name": "Bella", "breed": "Golden Retriever", "image": "assets/Golden Retriever.jpg"},
    {"name": "Max", "breed": "Dachshund", "image": "assets/Dachshund.jpg"},
    {"name": "Coco", "breed": "Poodle", "image": "assets/Poodle.jpg"},
    {"name": "Jack", "breed": "Jack Russell Terrier", "image": "assets/Jack Russell Terrier.jpg"},
    {"name": "Bolt", "breed": "Border Collie", "image": "assets/Border Collie.jpg"},
    {"name": "Bruno", "breed": "Bernese Mountain Dog", "image": "assets/Bernese Mountain Dog.jpg"},
    {"name": "Choco", "breed": "Chihuahua", "image": "assets/Chihuahua.jpg"},
    {"name": "Cody", "breed": "Corgi", "image": "assets/Corgi.jpg"},

    // 🐱 Cats
    {"name": "Lola", "breed": "Persian", "image": "assets/persian.jpg"},
    {"name": "Milo", "breed": "Siamese", "image": "assets/Siamese.jpg"},
    {"name": "Bella Cat", "breed": "American Short Hair", "image": "assets/American short hair.jpg"},
    {"name": "Buddy", "breed": "British Short Hair", "image": "assets/British short hair.jpg"},
    {"name": "Van", "breed": "Van Kedisi", "image": "assets/VanKedisi.jpg"},
    {"name": "Leo", "breed": "Maine Coon", "image": "assets/Maine Coon.jpg"},
    {"name": "Tiger", "breed": "Bengal", "image": "assets/Bengal.jpg"},
    {"name": "Aby", "breed": "Abyssinian", "image": "assets/Abyssinian.jpg"},
    {"name": "Sphinx", "breed": "Sphynx", "image": "assets/Sphynx.jpg"},
    {"name": "Foldy", "breed": "Scottish Fold", "image": "assets/Scottish Fold.jpg"},
    {"name": "Blue", "breed": "Russian Blue", "image": "assets/Russian Blue.jpg"},
    {"name": "Exo", "breed": "Exotic Shorthair", "image": "assets/Exotic Shorthair.jpg"},
    {"name": "Birman", "breed": "Birman", "image": "assets/Birman.jpg"},
    {"name": "Burmy", "breed": "Burmese", "image": "assets/Burmese.jpg"},
    {"name": "Hima", "breed": "Himalayan", "image": "assets/Himalayan.jpg"},
    {"name": "Bombay", "breed": "Bombay", "image": "assets/Bombay.jpg"},
    {"name": "Forest", "breed": "Norwegian Forest Cat", "image": "assets/Norwegian Forest Cat.jpg"},
    {"name": "Orient", "breed": "Oriental Shorthair", "image": "assets/Oriental Shorthair.jpg"},
    {"name": "Devon", "breed": "Devon Rex", "image": "assets/Devon Rex.jpg"},

    // 🦜 Birds
    {"name": "Rio", "breed": "Amazon Green Parrot", "image": "assets/Amazon Green Parrot.jpg"},
    {"name": "Grey", "breed": "Gray Parrot", "image": "assets/Gray Parrot.jpg"},
    {"name": "Mac", "breed": "Macaw", "image": "assets/Macaw.jpg"},
    {"name": "Snow", "breed": "White Parrot", "image": "assets/White Parrot.jpg"},

    // 🐢 Other
    {"name": "Hank", "breed": "Turtle", "image": "assets/Turtle.jpg"},
  ];

  String selectedPet = "Maxi";

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? "Good Morning ☀️"
        : hour < 17
        ? "Good Afternoon 🌤"
        : "Good Evening 🌙";

    final today = DateTime.now();

    final currentPet =
    pets.firstWhere((pet) => pet["name"] == selectedPet);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          "Pet Breed AI",
          style: TextStyle(
            color: brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: brown),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "${today.day}/${today.month}/${today.year}",
              style: const TextStyle(color: brown),
            ),
            const SizedBox(height: 25),

            /// 🐾 PET SELECTOR
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                  AssetImage(currentPet["image"]!),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedPet,
                    isExpanded: true,
                    underline: const SizedBox(),
                    dropdownColor: backgroundColor,
                    items: pets.map((pet) {
                      return DropdownMenuItem<String>(
                        value: pet["name"],
                        child: Text(
                          "${pet["name"]} • ${pet["breed"]}",
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPet = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// 🐶 IMAGE CARD
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                children: [
                  Image.asset(
                    currentPet["image"]!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      "${currentPet["name"]} • ${currentPet["breed"]}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// 🔥 QUICK ACTIONS
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _quickCard(context, "Facts", Icons.lightbulb, primary, const FactsPage()),
                _quickCard(context, "Library", Icons.menu_book, green, const EncyclopediaPage()),
                _quickCard(
                  context,
                  "AI Chat",
                  Icons.chat,
                  primary,
                  ChatbotPage(breed: currentPet["breed"]!),
                ),
                _quickCard(context, "Smart Match", Icons.favorite, green, const SmartMatchPage()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      Widget page,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}