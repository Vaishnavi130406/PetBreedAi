import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final supabase = Supabase.instance.client;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  /// PASSWORD STRENGTH
  String passwordStrength = "";
  Color strengthColor = Colors.red;
  double strengthValue = 0;

  void checkPasswordStrength(String value) {

    int score = 0;

    if (value.length >= 6) score++;
    if (value.length >= 8) score++;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;

    if (score <= 2) {
      passwordStrength = "Weak";
      strengthColor = Colors.red;
      strengthValue = 0.3;
    }
    else if (score == 3) {
      passwordStrength = "Medium";
      strengthColor = Colors.orange;
      strengthValue = 0.6;
    }
    else {
      passwordStrength = "Strong";
      strengthColor = Colors.green;
      strengthValue = 1.0;
    }

    setState(() {});
  }

  /// SUPABASE SIGNUP
  Future<void> signup() async {

    if (!_formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final response = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        data: {
          "name": nameController.text.trim(),
        },
      );

      if (response.user != null) {

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup Successful! Please Login")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }

    } on AuthException catch (error) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );

    } catch (error) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected Error: $error")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFD7B899),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),

          child: Form(
            key: _formKey,

            child: Column(
              children: [

                const Text(
                  "🐾 Create Account",
                  style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 40),

                TextFormField(
                  controller: nameController,
                  decoration: inputDecoration("Full Name"),
                  validator: (value) =>
                  value!.isEmpty ? "Enter your name" : null,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: emailController,
                  decoration: inputDecoration("Email"),
                  validator: (value) =>
                  value!.contains("@") ? null : "Enter valid email",
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  onChanged: checkPasswordStrength,
                  decoration: inputDecoration("Password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                if (passwordStrength.isNotEmpty)
                  LinearProgressIndicator(
                    value: strengthValue,
                    color: strengthColor,
                  ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirmPassword,
                  decoration: inputDecoration("Confirm Password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword =
                          !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                ElevatedButton(
                  onPressed: isLoading ? null : signup,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Sign Up"),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}