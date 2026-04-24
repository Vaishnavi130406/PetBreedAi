import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final supabase = Supabase.instance.client;

  String name = 'Pet Lover';
  String email = '';
  final nameController = TextEditingController();

  // 🎨 COLOR THEME
  static const Color backgroundColor = Color(0xFFFDF6EC);
  static const Color primary = Color(0xFFF4A261);
  static const Color green = Color(0xFF2A9D8F);
  static const Color brown = Color(0xFF5D4037);
  static const Color white = Colors.white;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    final user = supabase.auth.currentUser;
    setState(() {
      email = user?.email ?? 'No Email';
      name = user?.email?.split('@')[0] ?? 'Pet Lover';
    });
  }

  void editNameDialog() {
    nameController.text = name;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Username'),
        content: TextField(controller: nameController),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primary),
            onPressed: () {
              setState(() => name = nameController.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // 🔶 HEADER
              Container(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                decoration: const BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  children: [

                    // PROFILE IMAGE (NO CIRCLE)
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/pet.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi, There',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                              color: white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: editNameDialog,
                      icon: const Icon(Icons.edit, color: white),
                    ),
                    IconButton(
                      onPressed: logout,
                      icon: const Icon(Icons.logout, color: white),
                    ),
                  ],
                ),
              ),

              // 🔻 BODY
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'My Pets',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: .82,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      children: const [
                        _PetCard(name: 'Labrador', image: 'assets/Labrador.jpg'),
                        _PetCard(name: 'Persian Cat', image: 'assets/persian.jpg'),
                        _PetCard(name: 'Golden Retriever', image: 'assets/Golden Retriever.jpg'),
                        _PetCard(name: 'Macaw', image: 'assets/Macaw.jpg'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 👤 ACCOUNT
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            email,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Mumbai, India',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ],
                      ),
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

// 🐶 PET CARD
class _PetCard extends StatelessWidget {
  final String name;
  final String image;

  const _PetCard({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _ProfilePageState.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: _ProfilePageState.brown,
            ),
          ),
        ],
      ),
    );
  }
}