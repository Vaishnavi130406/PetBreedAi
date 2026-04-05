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

  String name = "Pet Lover";
  String email = "";

  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  /// GET USER
  void getUser() {
    final user = supabase.auth.currentUser;

    setState(() {
      email = user?.email ?? "No Email";
      name = user?.email?.split('@')[0] ?? "Pet Lover";
    });
  }

  /// EDIT USERNAME
  void editNameDialog() {

    nameController.text = name;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: const Text("Edit Username"),

          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Enter new username",
            ),
          ),

          actions: [

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = nameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),

          ],
        );
      },
    );
  }

  /// LOGOUT
  Future<void> logout() async {

    await supabase.auth.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    const Color beige = Color(0xFFF5E6D3);
    const Color orange = Color(0xFFF4A261);
    const Color brown = Color(0xFF8B5E3C);

    return Scaffold(

      backgroundColor: beige,

      appBar: AppBar(
        title: const Text("My Profile 🐾"),
        backgroundColor: orange,

        /// LOGOUT BUTTON
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// PROFILE IMAGE
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/pet.png"),
            ),

            const SizedBox(height: 20),

            /// NAME + EDIT BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: brown,
                  ),
                ),

                IconButton(
                  onPressed: editNameDialog,
                  icon: const Icon(Icons.edit, size: 18),
                ),

              ],
            ),

            const SizedBox(height: 8),

            /// EMAIL
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: brown,
              ),
            ),

          ],
        ),
      ),
    );
  }
}