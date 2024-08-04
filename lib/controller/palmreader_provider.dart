import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class PalmReadingProvider extends ChangeNotifier {
  String _detectionResult = '';
  XFile? _image;
  // Use ImageLabeler for general object detection
  // ignore: deprecated_member_use
  final ImageLabeler _imageLabeler = GoogleMlKit.vision.imageLabeler();

  bool _isPalmDetected = false;
  final ImagePicker _picker = ImagePicker();
  bool _scanAttempted = false; // New variable to track scan attempts

  @override
  void dispose() {
    _imageLabeler.close();
    super.dispose();
  }

  XFile? get image => _image;

  bool get isPalmDetected => _isPalmDetected;

  String get detectionResult => _detectionResult;

  bool get scanAttempted => _scanAttempted; // Getter for scan attempt

  Future<void> chooseFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = pickedFile;
      _scanAttempted = false; // Reset scan attempt when choosing a new file
      notifyListeners();
    }
  }

  Future<void> captureImage() async {
    final capturedFile = await _picker.pickImage(source: ImageSource.camera);

    if (capturedFile != null) {
      _image = capturedFile;
      _scanAttempted = false; // Reset scan attempt when capturing a new image
      notifyListeners();
    }
  }

  Future<void> detectPalm(XFile file) async {
    final inputImage = InputImage.fromFilePath(file.path);

    try {
      final labels = await _imageLabeler.processImage(inputImage);

      List<String> detectedLabels = labels
          .map((label) =>
              '${label.label} (${(label.confidence * 100).toStringAsFixed(2)}%)')
          .toList();
      _detectionResult = detectedLabels.join(', ');

      _isPalmDetected = labels.any((label) =>
          label.label.toLowerCase().contains('palm') ||
          label.label.toLowerCase().contains('hand'));

      _scanAttempted = true; // Set scan attempt to true after processing
      notifyListeners();
    } catch (e) {
      log('Error detecting palm: $e');
      throw Exception('Failed to detect palm.');
    }
  }
}
