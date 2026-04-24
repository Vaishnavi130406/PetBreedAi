import 'package:flutter/material.dart';

class SmartMatchPage extends StatefulWidget {
  const SmartMatchPage({super.key});

  @override
  State<SmartMatchPage> createState() => _SmartMatchPageState();
}

class _SmartMatchPageState extends State<SmartMatchPage> {
  // 🎨 COLORS
  static const Color beige = Color(0xFFF5E6D3);
  static const Color warmBrown = Color(0xFF8B5E3C);
  static const Color softOrange = Color(0xFFF4A261);
  static const Color greenAccent = Color(0xFF4CAF50);
  static const Color lightCream = Color(0xFFFDF6EC);

  String activityLevel = "Active";
  String livingType = "Apartment";
  String groomingTime = "Low";
  String budget = "Medium";
  bool hasKids = false;

  String result = "";
  int matchScore = 0;

  /// 🧠 SMART MATCH USING ALL 35 BREEDS
  void findMatch() {
    if (activityLevel == "Active" && livingType == "House") {
      result = "🐶 Labrador / Border Collie / German Shepherd\nHighly energetic and great for outdoor homes.";
      matchScore = 95;
    }
    else if (activityLevel == "Active" && livingType == "Apartment") {
      result = "🐱 Bengal / Abyssinian / Siamese\nActive pets suitable for smaller spaces.";
      matchScore = 90;
    }
    else if (activityLevel == "Moderate" && livingType == "House") {
      result = "🐶 Golden Retriever / Bernese Mountain Dog / Corgi\nBalanced temperament and family friendly.";
      matchScore = 92;
    }
    else if (activityLevel == "Low" && livingType == "Apartment") {
      result = "🐱 Persian / British Short Hair / Exotic Shorthair\nCalm and indoor-friendly pets.";
      matchScore = 88;
    }
    else if (groomingTime == "High") {
      result = "🐶 Poodle / 🐱 Persian / Himalayan\nRequire regular grooming and care.";
      matchScore = 85;
    }
    else if (budget == "Low") {
      result = "🐢 Turtle / 🐱 Bombay / American Short Hair\nLow maintenance and budget friendly.";
      matchScore = 80;
    }
    else if (hasKids) {
      result = "🐶 Golden Retriever / Labrador / 🐱 Birman\nVery friendly and safe with children.";
      matchScore = 94;
    }
    else {
      result = "🦜 Parrots (Macaw, Gray, Amazon) / 🐱 Russian Blue / 🐶 Dachshund\nBalanced companions depending on preference.";
      matchScore = 82;
    }

    setState(() {});
  }

  void resetForm() {
    setState(() {
      activityLevel = "Active";
      livingType = "Apartment";
      groomingTime = "Low";
      budget = "Medium";
      hasKids = false;
      result = "";
      matchScore = 0;
    });
  }

  Widget buildDropdown(
      String title,
      String value,
      List<String> items,
      void Function(String?) onChanged,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: warmBrown, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: softOrange.withOpacity(0.4)),
          ),
          child: DropdownButton<String>(
            dropdownColor: lightCream,
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            style: const TextStyle(color: warmBrown),
            items: items
                .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        title: const Text("Smart Matchmaker 🐾"),
        backgroundColor: softOrange,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: resetForm,
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [beige, lightCream],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdown(
                "Activity Level",
                activityLevel,
                ["Active", "Moderate", "Low"],
                    (value) => setState(() => activityLevel = value!),
              ),
              const SizedBox(height: 20),

              buildDropdown(
                "Living Situation",
                livingType,
                ["Apartment", "House"],
                    (value) => setState(() => livingType = value!),
              ),
              const SizedBox(height: 20),

              buildDropdown(
                "Grooming Time",
                groomingTime,
                ["Low", "Medium", "High"],
                    (value) => setState(() => groomingTime = value!),
              ),
              const SizedBox(height: 20),

              buildDropdown(
                "Monthly Budget",
                budget,
                ["Low", "Medium", "High"],
                    (value) => setState(() => budget = value!),
              ),
              const SizedBox(height: 20),

              SwitchListTile(
                value: hasKids,
                activeColor: greenAccent,
                title: const Text(
                  "Do you have kids?",
                  style: TextStyle(color: warmBrown),
                ),
                onChanged: (value) {
                  setState(() => hasKids = value);
                },
              ),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: softOrange,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: findMatch,
                  child: const Text(
                    "Find My Perfect Pet 🐶",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (result.isNotEmpty)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: warmBrown.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: warmBrown,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Match Score: $matchScore%",
                        style: const TextStyle(color: warmBrown),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: matchScore / 100,
                        backgroundColor: lightCream,
                        color: greenAccent,
                        minHeight: 8,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}