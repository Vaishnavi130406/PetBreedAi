import 'package:flutter/material.dart';
import 'breed_data.dart';

class EncyclopediaPage extends StatefulWidget {
  const EncyclopediaPage({super.key});

  @override
  State<EncyclopediaPage> createState() => _EncyclopediaPageState();
}

class _EncyclopediaPageState extends State<EncyclopediaPage> {

  final TextEditingController _searchController = TextEditingController();
  Set<String> favorites = {};
  String searchQuery = "";

  /// 🖼 Breed → Asset Image Mapping
  final Map<String, String> breedImages = {
    "American Short Hair": "assets/American short hair.jpg",
    "British Short Hair": "assets/British short hair.jpg",
    "Siamese": "assets/Siamese.jpg",
    "Persian": "assets/persian.jpg",
    "Vankedisi": "assets/Vankedisi.jpg",

    "Golden Retriever": "assets/Golden Retriever.jpg",
    "Labrador": "assets/Labrador.jpg",
    "German Shepherd": "assets/German Shepherd.jpg",
    "Dachshund": "assets/Dachshund.jpg",
    "Bulldog": "assets/Bulldog.jpg",

    "Gray Parrot": "assets/Gray parrot (28).jpg",
    "Amazon Green Parrot": "assets/Amazon Green Parrot.jpg",
    "White Parrot": "assets/white parrot (2).png",
    "Macaw": "assets/macaw (1).jpg",

    "Turtle": "assets/Turtle.jpg",
  };

  @override
  Widget build(BuildContext context) {

    const Color backgroundColor = Color(0xFFFDF6EC);
    const Color primary = Color(0xFFF4A261);
    const Color green = Color(0xFF2A9D8F);
    const Color brown = Color(0xFF5D4037);

    final breeds = breedDetails.entries
        .where((breed) =>
        breed.key.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          "Pet Encyclopedia 🐾",
          style: TextStyle(
            color: brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: brown),
      ),

      body: Column(
        children: [

          /// 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search breed...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 📚 BREED LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: breeds.length,
              itemBuilder: (context, index) {

                final breedName = breeds[index].key;
                final breedInfo = breeds[index].value;

                bool isFav = favorites.contains(breedName);

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.15),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: ExpansionTile(

                    leading: CircleAvatar(
                      backgroundColor: primary.withOpacity(0.2),
                      child: const Icon(Icons.pets, color: primary),
                    ),

                    title: Text(
                      breedName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: brown,
                      ),
                    ),

                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? primary : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFav) {
                            favorites.remove(breedName);
                          } else {
                            favorites.add(breedName);
                          }
                        });
                      },
                    ),

                    childrenPadding: const EdgeInsets.all(16),

                    children: [

                      /// 🖼 Local Asset Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          breedImages[breedName] ?? "assets/pet.png",
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// 📊 Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _statBox("Energy", green),
                          _statBox("Size", primary),
                          _statBox("Shedding", green),
                        ],
                      ),

                      const SizedBox(height: 15),

                      /// 📖 Detailed Info
                      _paragraph(
                          "Origin",
                          "The $breedName originates from ${breedInfo.origin}. "
                              "It has been historically known for its loyalty and companionship qualities."),

                      _paragraph(
                          "Temperament",
                          breedInfo.temperament +
                              ". They are affectionate, intelligent and adapt well to families."),

                      _paragraph(
                          "Lifespan",
                          "On average, $breedName lives around ${breedInfo.lifespan}. "
                              "Proper care and nutrition can improve life expectancy."),

                      _paragraph(
                          "Food & Diet",
                          "Recommended diet includes high-protein dog food, "
                              "lean meats like chicken or fish, vegetables like carrots and peas, "
                              "and fresh water. Avoid excessive treats and processed food."),

                      _paragraph(
                          "Care & Grooming",
                          "Regular brushing, periodic bathing, nail trimming, "
                              "and vet checkups are essential. Grooming frequency depends on coat type."),

                      _paragraph(
                          "Health Tips",
                          "Ensure daily exercise, mental stimulation, "
                              "routine vaccinations, and weight monitoring to keep your pet healthy."),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 📊 Stat Box
  Widget _statBox(String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  /// 📖 Paragraph Widget
  Widget _paragraph(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Color(0xFF5D4037)),
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: content),
          ],
        ),
      ),
    );
  }
}