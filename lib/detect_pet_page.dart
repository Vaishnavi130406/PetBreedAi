import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetectPetPage extends StatefulWidget {
  const DetectPetPage({Key? key}) : super(key: key);

  @override
  State<DetectPetPage> createState() => _DetectPetPageState();
}

class _DetectPetPageState extends State<DetectPetPage> {

  Interpreter? _interpreter;
  File? _image;

  String detectedBreed = "No prediction yet";
  double confidence = 0.0;

  final picker = ImagePicker();
  final supabase = Supabase.instance.client;

  List<String> labels = [];

  bool isProcessing = false;

  static const Color backgroundColor = Color(0xFFFDF6EC);
  static const Color primary = Color(0xFFF4A261);
  static const Color green = Color(0xFF2A9D8F);
  static const Color brown = Color(0xFF5D4037);

  @override
  void initState() {
    super.initState();
    initModel();
  }

  Future<void> initModel() async {
    await loadLabels();
    await loadModel();
  }

  /// LOAD MODEL
  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset("assets/model_unquant.tflite");
  }

  /// LOAD LABELS
  Future<void> loadLabels() async {
    final labelData = await rootBundle.loadString("assets/labels.txt");

    labels = labelData
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  /// CAMERA
  Future<void> pickFromCamera() async {

    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      processImage(File(pickedFile.path));
    }
  }

  /// GALLERY
  Future<void> pickFromGallery() async {

    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      processImage(File(pickedFile.path));
    }
  }

  void processImage(File imageFile) {

    setState(() {
      _image = imageFile;
      detectedBreed = "Analyzing...";
      confidence = 0;
    });

    classifyImage(imageFile);
  }

  /// CLASSIFY IMAGE
  void classifyImage(File image) async {

    if (_interpreter == null) return;

    var inputShape = _interpreter!.getInputTensor(0).shape;

    int height = inputShape[1];
    int width = inputShape[2];

    img.Image? originalImage =
    img.decodeImage(image.readAsBytesSync());

    if (originalImage == null) return;

    img.Image resizedImage =
    img.copyResize(originalImage, width: width, height: height);

    var input = List.generate(
      1,
          (_) => List.generate(
        height,
            (y) => List.generate(
          width,
              (x) {
            final pixel = resizedImage.getPixel(x, y);

            return [
              pixel.r / 255.0,
              pixel.g / 255.0,
              pixel.b / 255.0
            ];
          },
        ),
      ),
    );

    var output = List.generate(1, (_) => List.filled(labels.length, 0.0));

    _interpreter!.run(input, output);

    List<double> scores = List<double>.from(output[0]);

    double maxScore = scores.reduce(max);
    int index = scores.indexOf(maxScore);

    setState(() {
      detectedBreed = labels[index];
      confidence = maxScore;
    });
  }

  /// SAVE IMAGE + BREED TO SUPABASE
  Future<void> saveDetection(File image) async {

    setState(() {
      isProcessing = true;
    });

    try {

      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}.jpg";

      /// Upload image
      await supabase.storage
          .from("pet-images")
          .upload(
        fileName,
        image,
        fileOptions: const FileOptions(
          cacheControl: '3600',
          upsert: false,
        ),
      );

      final imageUrl = supabase.storage
          .from("pet-images")
          .getPublicUrl(fileName);

      /// Insert into history table
      await supabase.from("pet_history").insert({

        "breed": detectedBreed,
        "confidence": confidence,
        "image_url": imageUrl,
        "created_at": DateTime.now().toIso8601String()

      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Breed saved to history"),
        ),
      );
    } catch (e) {

      print("Save Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }

    setState(() {
      isProcessing = false;
    });
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pet Breed Detector",
          style: TextStyle(
            color: brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            /// IMAGE PREVIEW
            if (_image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(_image!, height: 250),
              )
            else
              const Text("No image selected"),

            const SizedBox(height: 30),

            /// BREED RESULT
            Text(
              detectedBreed,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: brown,
              ),
            ),

            const SizedBox(height: 15),

            /// CONFIDENCE BAR
            if (confidence > 0)
              Column(
                children: [

                  LinearProgressIndicator(
                    value: confidence,
                    color: green,
                    minHeight: 10,
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Confidence: ${(confidence * 100).toStringAsFixed(2)}%",
                  ),

                  const SizedBox(height: 20),

                  /// SAVE BUTTON
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                    ),
                    onPressed: () {
                      if (_image != null) {
                        saveDetection(_image!);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save Breed"),
                  ),
                ],
              ),

            const SizedBox(height: 30),

            if (isProcessing)
              const CircularProgressIndicator(),

            const SizedBox(height: 20),

            /// CAMERA + GALLERY BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                  ),
                  onPressed: pickFromCamera,
                  child: const Text("Camera"),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                  ),
                  onPressed: pickFromGallery,
                  child: const Text("Gallery"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}