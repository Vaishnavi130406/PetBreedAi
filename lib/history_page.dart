import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  final supabase = Supabase.instance.client;

  List historyList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  /// FETCH HISTORY FROM SUPABASE
  Future<void> fetchHistory() async {

    try {

      final data = await supabase
          .from('pet_history')
          .select()
          .order('created_at', ascending: false);

      setState(() {
        historyList = data;
        isLoading = false;
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  /// DELETE HISTORY ITEM
  Future<void> deleteHistory(int id) async {

    await supabase
        .from('pet_history')
        .delete()
        .eq('id', id);

    fetchHistory();
  }

  @override
  Widget build(BuildContext context) {

    const Color backgroundColor = Color(0xFFFDF6EC);
    const Color primary = Color(0xFFF4A261);
    const Color brown = Color(0xFF5D4037);

    return Scaffold(

      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detection History",
          style: TextStyle(
            color: brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: brown),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : historyList.isEmpty
          ? const Center(
        child: Text(
          "No History Found",
          style: TextStyle(fontSize: 18),
        ),
      )
          : RefreshIndicator(

        onRefresh: fetchHistory,

        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: historyList.length,

          itemBuilder: (context, index) {

            final item = historyList[index];

            /// FIXED CONFIDENCE CONVERSION
            double confidence =
                double.tryParse(item['confidence'].toString()) ?? 0;

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              elevation: 3,
              margin: const EdgeInsets.only(bottom: 15),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [

                    /// IMAGE
                    if (item['image_url'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item['image_url'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),

                    const SizedBox(width: 15),

                    /// BREED INFO
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            item['breed'] ?? "Unknown Breed",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "Confidence: ${(confidence * 100).toStringAsFixed(2)}%",
                            style: const TextStyle(fontSize: 14),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            item['created_at'] ?? "",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// DELETE BUTTON
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteHistory(item['id'] as int);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}