import 'package:flutter/material.dart';

class SmartMatchPage extends StatefulWidget {
  const SmartMatchPage({super.key});

  @override
  State<SmartMatchPage> createState() => _SmartMatchPageState();
}

class _SmartMatchPageState extends State<SmartMatchPage> {

  // 🎨 PET BREED AI WARM COLOR PALETTE
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

  void findMatch() {
    if (activityLevel == "Active" && livingType == "House") {
      result =
      "🐶 Labrador\nEnergetic, loyal and great for outdoor families.";
      matchScore = 95;
    } else if (livingType == "Apartment" && groomingTime == "Low") {
      result =
      "🐱 Persian Cat\nCalm, indoor-friendly and low activity needs.";
      matchScore = 88;
    } else if (hasKids) {
      result =
      "🐶 Golden Retriever\nVery friendly and excellent with children.";
      matchScore = 92;
    } else {
      result =
      "🐾 Indie Dog\nAdaptable, intelligent and budget friendly.";
      matchScore = 80;
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
                .map(
                  (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              ),
            )
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
                    (value) {
                  if (value != null) {
                    setState(() => activityLevel = value);
                  }
                },
              ),
              const SizedBox(height: 20),

              buildDropdown(
                "Living Situation",
                livingType,
                ["Apartment", "House"],
                    (value) {
                  if (value != null) {
                    setState(() => livingType = value);
                  }
                },
              ),
              const SizedBox(height: 20),

              buildDropdown(
                "Grooming Time",
                groomingTime,
                ["Low", "Medium", "High"],
                    (value) {
                  if (value != null) {
                    setState(() => groomingTime = value);
                  }
                },
              ),
              const SizedBox(height: 20),

              buildDropdown(
                "Monthly Budget",
                budget,
                ["Low", "Medium", "High"],
                    (value) {
                  if (value != null) {
                    setState(() => budget = value);
                  }
                },
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