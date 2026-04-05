import 'package:flutter/material.dart';

class BreedDetailPage extends StatelessWidget {
  final Map breed;

  BreedDetailPage({required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(breed['name'])),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Origin: ${breed['origin']}"),
            Text("Lifespan: ${breed['lifespan']}"),
            Text("Temperament: ${breed['temperament']}"),
            Text("Food: ${breed['food']}"),
          ],
        ),
      ),
    );
  }
}