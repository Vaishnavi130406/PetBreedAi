import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String apiKey = "YOUR_API_KEY"; // 🔴 PUT YOUR KEY HERE

  static Future<String> getResponse(String prompt) async {
    final url =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ],

          /// ✅ IMPORTANT: prevents repetitive answers
          "generationConfig": {
            "temperature": 0.8,
            "topK": 40,
            "topP": 0.9,
            "maxOutputTokens": 200,
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data["candidates"][0]["content"]["parts"][0]["text"]
            .toString()
            .trim();
      } else {
        return "Error: ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}