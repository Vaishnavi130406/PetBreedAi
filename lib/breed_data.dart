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

  // 🐶 DOGS
  "Labrador": const BreedInfo(
    origin: "Canada",
    food: "High-protein dog food",
    lifespan: "10-12 years",
    temperament: "Friendly, Intelligent",
    grooming: "Weekly brushing",
    training: "Easy to train",
  ),

  "German Shepherd": const BreedInfo(
    origin: "Germany",
    food: "High-protein diet",
    lifespan: "9-13 years",
    temperament: "Confident, Loyal",
    grooming: "Regular brushing",
    training: "Needs firm training",
  ),

  "Golden Retriever": const BreedInfo(
    origin: "Scotland",
    food: "Balanced diet",
    lifespan: "10-12 years",
    temperament: "Friendly, Loyal",
    grooming: "Frequent brushing",
    training: "Very easy to train",
  ),

  "Bulldog": const BreedInfo(
    origin: "England",
    food: "Balanced dog food",
    lifespan: "8-10 years",
    temperament: "Calm, Gentle",
    grooming: "Low grooming",
    training: "Needs patience",
  ),

  "Dachshund": const BreedInfo(
    origin: "Germany",
    food: "Small breed diet",
    lifespan: "12-16 years",
    temperament: "Brave, Curious",
    grooming: "Low grooming",
    training: "Stubborn but trainable",
  ),

  "Poodle": const BreedInfo(
    origin: "France",
    food: "High-quality dog food",
    lifespan: "12-15 years",
    temperament: "Intelligent, Active",
    grooming: "Frequent grooming",
    training: "Highly trainable",
  ),

  "Jack Russell Terrier": const BreedInfo(
    origin: "England",
    food: "High-energy diet",
    lifespan: "13-16 years",
    temperament: "Energetic, Bold",
    grooming: "Low grooming",
    training: "Needs active training",
  ),

  "Border Collie": const BreedInfo(
    origin: "UK",
    food: "High-protein diet",
    lifespan: "12-15 years",
    temperament: "Highly intelligent",
    grooming: "Moderate grooming",
    training: "Excellent working dog",
  ),

  "Bernese Mountain Dog": const BreedInfo(
    origin: "Switzerland",
    food: "Large breed diet",
    lifespan: "7-10 years",
    temperament: "Calm, Affectionate",
    grooming: "Heavy shedding",
    training: "Needs consistency",
  ),

  "Chihuahua": const BreedInfo(
    origin: "Mexico",
    food: "Small dog diet",
    lifespan: "14-17 years",
    temperament: "Alert, Lively",
    grooming: "Low grooming",
    training: "Needs gentle training",
  ),

  "Corgi": const BreedInfo(
    origin: "Wales",
    food: "Balanced diet",
    lifespan: "12-15 years",
    temperament: "Playful, Smart",
    grooming: "Moderate grooming",
    training: "Easy to train",
  ),

  // 🐱 CATS
  "Persian": const BreedInfo(
    origin: "Iran",
    food: "Premium cat food",
    lifespan: "12-15 years",
    temperament: "Calm, Quiet",
    grooming: "Daily grooming",
    training: "Low training",
  ),

  "Siamese": const BreedInfo(
    origin: "Thailand",
    food: "High-quality food",
    lifespan: "12-20 years",
    temperament: "Social, Vocal",
    grooming: "Low grooming",
    training: "Very intelligent",
  ),

  "American Short Hair": const BreedInfo(
    origin: "USA",
    food: "Balanced diet",
    lifespan: "15-20 years",
    temperament: "Easygoing",
    grooming: "Occasional brushing",
    training: "Easy to adapt",
  ),

  "British Short Hair": const BreedInfo(
    origin: "UK",
    food: "Balanced diet",
    lifespan: "12-20 years",
    temperament: "Calm",
    grooming: "Low grooming",
    training: "Indoor friendly",
  ),

  "VanKedisi": const BreedInfo(
    origin: "Turkey",
    food: "High-protein diet",
    lifespan: "12-17 years",
    temperament: "Active",
    grooming: "Moderate grooming",
    training: "Trainable",
  ),

  "Maine Coon": const BreedInfo(
    origin: "USA",
    food: "High-protein diet",
    lifespan: "10-13 years",
    temperament: "Gentle giant",
    grooming: "Regular grooming",
    training: "Easy to train",
  ),

  "Bengal": const BreedInfo(
    origin: "USA",
    food: "Protein-rich diet",
    lifespan: "12-16 years",
    temperament: "Active, Playful",
    grooming: "Low grooming",
    training: "Needs stimulation",
  ),

  "Abyssinian": const BreedInfo(
    origin: "Ethiopia",
    food: "Balanced diet",
    lifespan: "12-15 years",
    temperament: "Energetic",
    grooming: "Low grooming",
    training: "Highly active",
  ),

  "Sphynx": const BreedInfo(
    origin: "Canada",
    food: "High-energy diet",
    lifespan: "8-14 years",
    temperament: "Friendly",
    grooming: "Skin cleaning needed",
    training: "Social",
  ),

  "Scottish Fold": const BreedInfo(
    origin: "Scotland",
    food: "Balanced diet",
    lifespan: "11-14 years",
    temperament: "Calm",
    grooming: "Low grooming",
    training: "Easygoing",
  ),

  "Russian Blue": const BreedInfo(
    origin: "Russia",
    food: "High-quality food",
    lifespan: "15-20 years",
    temperament: "Quiet",
    grooming: "Low grooming",
    training: "Independent",
  ),

  "Exotic Shorthair": const BreedInfo(
    origin: "USA",
    food: "Balanced diet",
    lifespan: "12-15 years",
    temperament: "Calm",
    grooming: "Moderate grooming",
    training: "Easy",
  ),

  "Birman": const BreedInfo(
    origin: "Myanmar",
    food: "Balanced diet",
    lifespan: "12-16 years",
    temperament: "Gentle",
    grooming: "Moderate grooming",
    training: "Social",
  ),

  "Burmese": const BreedInfo(
    origin: "Myanmar",
    food: "High-protein diet",
    lifespan: "10-16 years",
    temperament: "Playful",
    grooming: "Low grooming",
    training: "Interactive",
  ),

  "Himalayan": const BreedInfo(
    origin: "USA",
    food: "Premium diet",
    lifespan: "9-15 years",
    temperament: "Calm",
    grooming: "Daily grooming",
    training: "Low activity",
  ),

  "Bombay": const BreedInfo(
    origin: "USA",
    food: "Balanced diet",
    lifespan: "12-16 years",
    temperament: "Affectionate",
    grooming: "Low grooming",
    training: "Easy",
  ),

  "Norwegian Forest Cat": const BreedInfo(
    origin: "Norway",
    food: "High-protein diet",
    lifespan: "14-16 years",
    temperament: "Independent",
    grooming: "Heavy coat care",
    training: "Moderate",
  ),

  "Oriental Shorthair": const BreedInfo(
    origin: "UK",
    food: "Balanced diet",
    lifespan: "12-15 years",
    temperament: "Social",
    grooming: "Low grooming",
    training: "Smart",
  ),

  "Devon Rex": const BreedInfo(
    origin: "UK",
    food: "High-energy diet",
    lifespan: "10-15 years",
    temperament: "Playful",
    grooming: "Low grooming",
    training: "Very active",
  ),

  // 🐦 BIRDS
  "Amazon Green Parrot": const BreedInfo(
    origin: "South America",
    food: "Fruits & seeds",
    lifespan: "40-50 years",
    temperament: "Talkative",
    grooming: "Low",
    training: "Very intelligent",
  ),

  "Gray Parrot": const BreedInfo(
    origin: "Africa",
    food: "Seeds & nuts",
    lifespan: "40-60 years",
    temperament: "Smart",
    grooming: "Low",
    training: "Excellent mimic",
  ),

  "Macaw": const BreedInfo(
    origin: "South America",
    food: "Nuts & fruits",
    lifespan: "30-50 years",
    temperament: "Playful",
    grooming: "Low",
    training: "Needs stimulation",
  ),

  "White Parrot": const BreedInfo(
    origin: "Australia",
    food: "Seeds & fruits",
    lifespan: "20-40 years",
    temperament: "Friendly",
    grooming: "Low",
    training: "Can learn tricks",
  ),

  // 🐢
  "Turtle": const BreedInfo(
    origin: "Worldwide",
    food: "Leafy greens",
    lifespan: "30-80 years",
    temperament: "Calm",
    grooming: "Very low",
    training: "Minimal",
  ),
};