import 'dart:io';
import 'package:flutter/material.dart';
import 'package:palm/view/home/widgets/Buttons.dart';
import 'package:provider/provider.dart';
import 'package:palm/controller/palmreader_provider.dart';
import 'package:palm/utils/constants/colors.dart';
import 'package:palm/utils/constants/size.dart';

class PalmReadingScreen extends StatelessWidget {
  const PalmReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'P A L M  R E A D I N G',
          style: TextStyle(
            color: sWhite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: sPurple.shade100,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: sPurple.shade100.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          height: size.height * 0.7,
          width: size.width * 0.85,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.02),
                Consumer<PalmReadingProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        if (provider.scanAttempted &&
                            !provider.isPalmDetected &&
                            provider.image != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red, width: 1),
                            ),
                            child: const Text(
                              'No palm is detected in the uploaded image. Please try again.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (provider.scanAttempted && provider.isPalmDetected)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green, width: 1),
                            ),
                            child: const Text(
                              'Palm detected successfully!',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(height: size.height * 0.03),
                        provider.image == null
                            ? Image.asset(
                                "assets/images/Screenshot 2024-08-04 at 12.23.14 PM.png",
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(provider.image!.path),
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                        SizedBox(height: size.height * 0.03),
                        Column(
                          children: [
                            chooseFileButton(provider),
                            SizedBox(height: size.height * 0.02),
                            const Text(
                              'OR',
                              style: TextStyle(
                                color: sBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            captureButton(provider),
                            SizedBox(height: size.height * 0.02),
                            scanButton(provider),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        closeButton(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
