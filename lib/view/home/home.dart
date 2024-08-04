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
          'PALM READING',
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: sPurple.shade100.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20)),
          height: size.width * 1.1,
          width: size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sheight20,
                Consumer<PalmReadingProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        if (provider.scanAttempted &&
                            !provider.isPalmDetected &&
                            provider.image != null)
                          const Text(
                            'No Palm is detected in the uploaded image, please try again.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (provider.scanAttempted && provider.isPalmDetected)
                          const Text(
                            'Palm detected successfully!',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        sheight20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.image == null
                                ? Image.asset(
                                    "assets/images/Screenshot 2024-08-04 at 12.23.14 PM.png",
                                    height: 100,
                                    width: 100,
                                  )
                                : Image.file(
                                    File(provider.image!.path),
                                    height: 100,
                                    width: 100,
                                  ),
                            sheight20,
                            Column(
                              children: [
                                chooseFileButton(provider),
                                sheight10,
                                const Text('OR'),
                                sheight10,
                                captureButton(provider),
                                sheight10,
                                scanButton(provider),
                              ],
                            ),
                          ],
                        ),
                        sheight20,
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
