import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  final String breed;

  const ChatbotPage({
    super.key,
    required this.breed,
  });

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<Map<String, String>> messages = [];

  static const Color beige = Color(0xFFF5E6D3);
  static const Color warmBrown = Color(0xFF8B5E3C);
  static const Color softOrange = Color(0xFFF4A261);

  /// BREED DATABASE (UPDATED ALL 35)
  final Map<String, Map<String, String>> breedDatabase = {

    // 🐶 DOGS
    "labrador": buildBreedData(
        lifespan: "10–12 years",
        temperament: "Friendly, outgoing and loyal.",
        energy: "Very high energy.",
        grooming: "Weekly brushing.",
        health: "Hip and elbow dysplasia risk."),

    "german shepherd": buildBreedData(
        lifespan: "9–13 years",
        temperament: "Confident, protective and smart.",
        energy: "Very active.",
        grooming: "Heavy shedding.",
        health: "Hip dysplasia common."),

    "golden retriever": buildBreedData(
        lifespan: "10–12 years",
        temperament: "Gentle, intelligent and loving.",
        energy: "High energy.",
        grooming: "Frequent brushing required.",
        health: "Joint and heart issues."),

    "bulldog": buildBreedData(
        lifespan: "8–10 years",
        temperament: "Calm and friendly.",
        energy: "Low energy.",
        grooming: "Low grooming needs.",
        health: "Breathing problems common."),

    "dachshund": buildBreedData(
        lifespan: "12–16 years",
        temperament: "Clever and playful.",
        energy: "Moderate energy.",
        grooming: "Low grooming.",
        health: "Back problems common."),

    "poodle": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Highly intelligent and active.",
        energy: "High energy.",
        grooming: "Regular grooming required.",
        health: "Eye and joint issues."),

    "jack russell terrier": buildBreedData(
        lifespan: "13–16 years",
        temperament: "Energetic, bold, lively.",
        energy: "Very high energy.",
        grooming: "Low grooming.",
        health: "Hyperactivity and joint issues."),

    "border collie": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Extremely intelligent and hardworking.",
        energy: "Very high energy.",
        grooming: "Weekly brushing.",
        health: "Eye problems."),

    "bernese mountain dog": buildBreedData(
        lifespan: "7–10 years",
        temperament: "Gentle, affectionate.",
        energy: "Moderate.",
        grooming: "Heavy shedding.",
        health: "Cancer risk."),

    "chihuahua": buildBreedData(
        lifespan: "12–20 years",
        temperament: "Alert and lively.",
        energy: "Low.",
        grooming: "Low grooming.",
        health: "Dental issues."),

    "corgi": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Playful and smart.",
        energy: "Moderate.",
        grooming: "Heavy shedding.",
        health: "Back issues."),

    // 🐱 CATS
    "persian": buildBreedData(
        lifespan: "12–17 years",
        temperament: "Calm and affectionate.",
        energy: "Low activity.",
        grooming: "Daily brushing required.",
        health: "Respiratory issues."),

    "siamese": buildBreedData(
        lifespan: "12–20 years",
        temperament: "Vocal and social.",
        energy: "Active and playful.",
        grooming: "Low grooming.",
        health: "Dental issues."),

    "american shorthair": buildBreedData(
        lifespan: "15–20 years",
        temperament: "Easy-going.",
        energy: "Moderate activity.",
        grooming: "Low grooming.",
        health: "Generally healthy."),

    "british shorthair": buildBreedData(
        lifespan: "12–20 years",
        temperament: "Calm and independent.",
        energy: "Low to moderate.",
        grooming: "Weekly brushing.",
        health: "Obesity prone."),

    "van kedisi": buildBreedData(
        lifespan: "12–17 years",
        temperament: "Playful and intelligent.",
        energy: "Active.",
        grooming: "Moderate grooming.",
        health: "Generally healthy."),

    "maine coon": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Gentle giant.",
        energy: "Moderate.",
        grooming: "Heavy grooming.",
        health: "Heart issues."),

    "bengal": buildBreedData(
        lifespan: "12–16 years",
        temperament: "Active and wild.",
        energy: "High.",
        grooming: "Low grooming.",
        health: "Hyperactivity."),

    "abyssinian": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Curious and playful.",
        energy: "High.",
        grooming: "Low grooming.",
        health: "Dental issues."),

    "sphynx": buildBreedData(
        lifespan: "8–14 years",
        temperament: "Affectionate.",
        energy: "Moderate.",
        grooming: "Skin care needed.",
        health: "Skin issues."),

    "scottish fold": buildBreedData(
        lifespan: "11–14 years",
        temperament: "Calm and sweet.",
        energy: "Low.",
        grooming: "Low grooming.",
        health: "Joint issues."),

    "russian blue": buildBreedData(
        lifespan: "15–20 years",
        temperament: "Quiet and gentle.",
        energy: "Moderate.",
        grooming: "Low grooming.",
        health: "Healthy breed."),

    "exotic shorthair": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Calm and loving.",
        energy: "Low.",
        grooming: "Moderate grooming.",
        health: "Breathing issues."),

    "birman": buildBreedData(
        lifespan: "12–16 years",
        temperament: "Gentle and affectionate.",
        energy: "Moderate.",
        grooming: "Weekly brushing.",
        health: "Healthy."),

    "burmese": buildBreedData(
        lifespan: "12–18 years",
        temperament: "Social and playful.",
        energy: "Moderate.",
        grooming: "Low grooming.",
        health: "Diabetes risk."),

    "himalayan": buildBreedData(
        lifespan: "9–15 years",
        temperament: "Calm.",
        energy: "Low.",
        grooming: "Daily grooming.",
        health: "Respiratory issues."),

    "bombay": buildBreedData(
        lifespan: "12–16 years",
        temperament: "Playful.",
        energy: "Moderate.",
        grooming: "Low grooming.",
        health: "Healthy."),

    "norwegian forest cat": buildBreedData(
        lifespan: "14–16 years",
        temperament: "Independent.",
        energy: "Moderate.",
        grooming: "Heavy grooming.",
        health: "Joint issues."),

    "oriental shorthair": buildBreedData(
        lifespan: "12–15 years",
        temperament: "Talkative.",
        energy: "High.",
        grooming: "Low grooming.",
        health: "Dental issues."),

    "devon rex": buildBreedData(
        lifespan: "10–15 years",
        temperament: "Mischievous.",
        energy: "High.",
        grooming: "Low grooming.",
        health: "Skin issues."),

    // 🦜 BIRDS
    "amazon green parrot": buildBreedData(
        lifespan: "40–60 years",
        temperament: "Social and talkative.",
        energy: "Very active.",
        grooming: "Feather care required.",
        health: "Needs mental stimulation."),

    "gray parrot": buildBreedData(
        lifespan: "40–50 years",
        temperament: "Highly intelligent.",
        energy: "Active.",
        grooming: "Regular care needed.",
        health: "Prone to stress."),

    "macaw": buildBreedData(
        lifespan: "50+ years",
        temperament: "Colorful and social.",
        energy: "Very energetic.",
        grooming: "Large space required.",
        health: "Sensitive to diet."),

    "white parrot": buildBreedData(
        lifespan: "40–60 years",
        temperament: "Affectionate.",
        energy: "Active.",
        grooming: "Feather care required.",
        health: "Needs social interaction."),

    // 🐢
    "turtle": buildBreedData(
        lifespan: "20–80 years",
        temperament: "Quiet and calm.",
        energy: "Low activity.",
        grooming: "Clean habitat required.",
        health: "Shell infections possible."),
  };

  static Map<String, String> buildBreedData({
    required String lifespan,
    required String temperament,
    required String energy,
    required String grooming,
    required String health,
  }) {
    return {
      "lifespan": lifespan,
      "temperament": temperament,
      "exercise": energy,
      "grooming": grooming,
      "health": health,
      "food": "Provide species-appropriate balanced diet.",
      "training": "Use positive reinforcement training.",
    };
  }

// ✅ REST CODE SAME (UNCHANGED)
  @override
  void initState() {
    super.initState();

    messages.add({
      "sender": "bot",
      "text":
      "Hello 👋 I am your Pet Breed AI Assistant.\n\nAsk me anything about ${widget.breed} 🐾"
    });
  }

  void sendMessage(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "text": query});
      messages.add({"sender": "bot", "text": getResponse(query)});
    });

    controller.clear();

    /// scroll to latest message
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  String getResponse(String query) {
    String breedKey = widget.breed.toLowerCase().trim();

    if (!breedDatabase.containsKey(breedKey)) {
      return "Sorry, no data available for ${widget.breed}.";
    }

    var info = breedDatabase[breedKey]!;

    query = query.toLowerCase();

    if (query.contains("food")) return info["food"]!;
    if (query.contains("training")) return info["training"]!;
    if (query.contains("grooming")) return info["grooming"]!;
    if (query.contains("exercise") || query.contains("energy")) {
      return info["exercise"]!;
    }
    if (query.contains("health")) return info["health"]!;
    if (query.contains("lifespan")) return info["lifespan"]!;
    if (query.contains("temperament")) return info["temperament"]!;

    return """
Here is basic info about ${widget.breed}:

• Lifespan: ${info["lifespan"]}
• Temperament: ${info["temperament"]}
• Exercise: ${info["exercise"]}
• Grooming: ${info["grooming"]}
• Health: ${info["health"]}

You can also ask about Food or Training 🐾
""";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      appBar: AppBar(
        backgroundColor: warmBrown,
        title: Text("${widget.breed} AI Chat"),
      ),
      body: Column(
        children: [

          /// CHAT MESSAGES
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {

                final msg = messages[index];
                final isUser = msg["sender"] == "user";

                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? softOrange : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      msg["text"]!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),

          /// INPUT AREA
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: sendMessage,
                    decoration: const InputDecoration(
                      hintText: "Ask something...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: warmBrown),
                  onPressed: () => sendMessage(controller.text),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}