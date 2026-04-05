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
  final List<Map<String, String>> pets = [
    {"name": "Maxi", "breed": "Bulldog", "image": "assets/Bulldog.jpg"},
    {"name": "Rocky", "breed": "Labrador", "image": "assets/Labrador.jpg"},
    {"name": "Luna", "breed": "German Shepherd", "image": "assets/German Shepherd.jpg"},
    {"name": "Bella", "breed": "Golden Retriever", "image": "assets/Golden Retriever.jpg"},
    {"name": "Max", "breed": "Dachshund", "image": "assets/Dachshund.jpg"},
    {"name": "Lola", "breed": "Persian", "image": "assets/persian.jpg"},
    {"name": "Milo", "breed": "Siamese", "image": "assets/Siamese.jpg"},
    {"name": "Bella (Cat)", "breed": "American Short Hair", "image": "assets/American short hair.jpg"},
    {"name": "Buddy", "breed": "British Short Hair", "image": "assets/British short hair.jpg"},
    {"name": "Charlie", "breed": "Vankedisi", "image": "assets/Vankedisi.jpg"},
    {"name": "Daisy", "breed": "Amazon Green Parrot", "image": "assets/Amazon Green Parrot.jpg"},
    {"name": "Evie", "breed": "Gray Parrot", "image": "assets/Gray parrot (28).jpg"},
    {"name": "Finn", "breed": "Macaw", "image": "assets/macaw (1).jpg"},
    {"name": "Greta", "breed": "White Parrot", "image": "assets/white parrot (2).jpg"},
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
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: brown,
                    ),
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
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _quickCard(
                  context,
                  "Facts",
                  Icons.lightbulb,
                  primary,
                  const FactsPage(),
                ),
                _quickCard(
                  context,
                  "Library",
                  Icons.menu_book,
                  green,
                  const EncyclopediaPage(),
                ),
                _quickCard(
                  context,
                  "AI Chat",
                  Icons.chat,
                  primary,
                  ChatbotPage(
                    breed: currentPet["breed"]!,
                  ),
                ),
                _quickCard(
                  context,
                  "Smart Match",
                  Icons.favorite,
                  green,
                  const SmartMatchPage(),
                ),
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