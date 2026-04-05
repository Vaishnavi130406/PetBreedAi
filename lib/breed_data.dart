class BreedInfo {
  final String origin;
  final String food;
  final String lifespan;
  final String temperament;
  final String grooming;
  final String training;

  const BreedInfo({
    required this.origin,
    required this.food,
    required this.lifespan,
    required this.temperament,
    required this.grooming,
    required this.training,
  });
}

final Map<String, BreedInfo> breedDetails = {

  "Labrador": const BreedInfo(
    origin: "Canada",
    food: "High-protein dog food",
    lifespan: "10-12 years",
    temperament: "Friendly, Intelligent, Outgoing",
    grooming: "Weekly brushing",
    training: "Responds well to positive reinforcement",
  ),

  "Golden Retriever": const BreedInfo(
    origin: "Scotland",
    food: "Balanced diet with proteins & fats",
    lifespan: "10-12 years",
    temperament: "Friendly, Loyal, Intelligent",
    grooming: "Frequent brushing required",
    training: "Easy to train, loves activities",
  ),

  "German Shepherd": const BreedInfo(
    origin: "Germany",
    food: "High-protein performance diet",
    lifespan: "9-13 years",
    temperament: "Confident, Courageous, Smart",
    grooming: "Brush 2-3 times weekly",
    training: "Needs firm & consistent training",
  ),

  "Bulldog": const BreedInfo(
    origin: "England",
    food: "Balanced dog food",
    lifespan: "8-10 years",
    temperament: "Gentle, Loyal, Calm",
    grooming: "Weekly brushing",
    training: "Needs patient training",
  ),

  "Dachshund": const BreedInfo(
    origin: "Germany",
    food: "High-quality small breed diet",
    lifespan: "12-16 years",
    temperament: "Brave, Curious, Stubborn",
    grooming: "Low grooming needs",
    training: "Needs consistent training",
  ),

  "Persian": const BreedInfo(
    origin: "Iran",
    food: "Premium dry & wet cat food",
    lifespan: "12-15 years",
    temperament: "Calm, Quiet, Gentle",
    grooming: "Daily brushing required",
    training: "Low training needs, indoor friendly",
  ),

  "Siamese": const BreedInfo(
    origin: "Thailand",
    food: "High-quality cat food",
    lifespan: "12-20 years",
    temperament: "Social, Vocal, Active",
    grooming: "Minimal grooming needed",
    training: "Highly intelligent, easy to train",
  ),

  // ✅ FIXED NAMES BELOW

  "American Short Hair": const BreedInfo(
    origin: "United States",
    food: "Balanced cat diet",
    lifespan: "15-20 years",
    temperament: "Easygoing, Playful",
    grooming: "Occasional brushing",
    training: "Adapts easily to home life",
  ),

  "British Short Hair": const BreedInfo(
    origin: "United Kingdom",
    food: "Balanced cat diet",
    lifespan: "12-20 years",
    temperament: "Calm, Easygoing",
    grooming: "Occasional brushing",
    training: "Adapts well indoors",
  ),

  "Vankedisi": const BreedInfo(
    origin: "Turkey",
    food: "High-protein cat food",
    lifespan: "12-17 years",
    temperament: "Active, Intelligent",
    grooming: "Moderate grooming",
    training: "Highly trainable",
  ),

  "Amazon Green Parrot": const BreedInfo(
    origin: "South America",
    food: "Seeds, fruits, vegetables",
    lifespan: "40-50 years",
    temperament: "Talkative, Social",
    grooming: "Low grooming",
    training: "Very intelligent",
  ),

  "Gray Parrot": const BreedInfo(
    origin: "Africa",
    food: "Seeds, nuts, fruits",
    lifespan: "40-60 years",
    temperament: "Smart, Sensitive",
    grooming: "Minimal grooming",
    training: "Excellent talking ability",
  ),

  "Macaw": const BreedInfo(
    origin: "Central & South America",
    food: "Nuts, fruits, seeds",
    lifespan: "30-50 years",
    temperament: "Playful, Loud",
    grooming: "Low grooming",
    training: "Needs mental stimulation",
  ),

  "White Parrot": const BreedInfo(
    origin: "Australia",
    food: "Seeds and fruits",
    lifespan: "20-40 years",
    temperament: "Friendly, Social",
    grooming: "Low grooming",
    training: "Can learn tricks",
  ),

  "Turtle": const BreedInfo(
    origin: "Worldwide",
    food: "Leafy greens, pellets",
    lifespan: "30-80 years",
    temperament: "Quiet, Calm",
    grooming: "Low maintenance",
    training: "Minimal training required",
  ),
};