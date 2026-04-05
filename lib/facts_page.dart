import 'package:flutter/material.dart';

class FactsPage extends StatelessWidget {
  const FactsPage({super.key});

  static const Color primary = Color(0xFFF4A261);
  static const Color backgroundColor = Color(0xFFFDF6EC);
  static const Color brown = Color(0xFF5D4037);

  final List<String> facts = const [

    // 🐶 Dogs
    "Dogs have about 300 million smell receptors.",
    "A dog's sense of smell is about 40 times stronger than humans.",
    "Labradors are one of the most popular dog breeds worldwide.",
    "German Shepherds are highly intelligent and trainable.",
    "Bulldogs are known for their gentle temperament.",
    "Golden Retrievers are excellent family pets and therapy dogs.",
    "Dachshunds were originally bred to hunt badgers.",
    "Dogs can understand up to 250 words and gestures.",
    "A dog’s nose print is unique, just like a human fingerprint.",
    "Dogs can hear sounds up to four times farther than humans.",

    // 🐱 Cats
    "Cats sleep for around 13-16 hours a day.",
    "Cats have five toes on their front paws but only four on their back paws.",
    "A group of cats is called a clowder.",
    "Cats can rotate their ears 180 degrees.",
    "Siamese cats are known for their striking blue eyes.",
    "Persian cats are famous for their long, luxurious fur.",
    "Cats use their whiskers to measure if they can fit through spaces.",
    "A cat’s purr can have healing effects and reduce stress.",
    "Cats can jump up to six times their body length.",
    "The world's oldest known pet cat existed over 9,000 years ago.",

    // 🦜 Birds
    "Parrots are among the most intelligent bird species.",
    "Macaws can live up to 50 years or more.",
    "African Gray Parrots can mimic human speech very accurately.",
    "Parrots use their beaks like a third foot for climbing.",
    "Some parrots can learn over 100 words.",
    "Birds have hollow bones which help them fly.",
    "Parrots form strong emotional bonds with their owners.",

    // 🐢 Turtle
    "Turtles can live for several decades, some over 100 years.",
    "A turtle’s shell is made of over 50 bones.",
    "Turtles can breathe through their cloaca in certain conditions.",
    "Sea turtles travel thousands of miles during migration.",
    "Turtles have existed for more than 200 million years.",

    // 🐾 General Pet Facts
    "Pets help reduce stress and improve mental health.",
    "Regular exercise keeps pets physically and mentally healthy.",
    "Proper grooming prevents many skin and coat problems.",
    "Routine vet visits increase a pet’s lifespan.",
    "Balanced nutrition is essential for every pet’s well-being."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Pet Facts"),
        backgroundColor: primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: facts.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                facts[index],
                style: const TextStyle(
                  color: brown,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}