import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  final List<String> savedBreeds;

  const SavedPage({super.key, required this.savedBreeds});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Saved Breeds")),
      body: savedBreeds.isEmpty
          ? const Center(
          child:
          Text("No breeds saved yet"))
          : ListView.builder(
        itemCount: savedBreeds.length,
        itemBuilder:
            (context, index) {
          return ListTile(
            leading:
            const Icon(Icons.pets),
            title:
            Text(savedBreeds[index]),
          );
        },
      ),
    );
  }
}