//Buttton
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palm/controller/palmreader_provider.dart';
import 'package:palm/utils/constants/colors.dart';

ElevatedButton closeButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 10),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: sBlack),
    onPressed: () {
      SystemNavigator.pop();
    },
    child: const Text(
      'Close',
      style: TextStyle(color: sWhite),
    ),
  );
}

ElevatedButton scanButton(PalmReadingProvider provider) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 10),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: sBlack),
    onPressed: provider.image != null
        ? () => provider.detectPalm(provider.image!)
        : null,
    child: const Text(
      'Scan',
      style: TextStyle(color: sWhite),
    ),
  );
}

ElevatedButton captureButton(PalmReadingProvider provider) {
  return ElevatedButton(
    onPressed: provider.captureImage,
    style: ElevatedButton.styleFrom(
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF007BFF)),
    child: const Text(
      'Capture',
      style: TextStyle(color: sWhite),
    ),
  );
}

Widget chooseFileButton(PalmReadingProvider provider) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: provider.chooseFile,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 10),
        shape: ContinuousRectangleBorder(
            side: BorderSide(color: sBlack.withOpacity(0.5))),
        foregroundColor: sBlack,
        backgroundColor: sWhite, // Text color
        elevation: 0, // Remove shadow
        padding: const EdgeInsets.all(0.1),
      ),
      child: const Text('Choose file'),
    ),
  );
}
