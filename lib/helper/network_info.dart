import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

import '../features/splash/controllers/splash_controller.dart';

class NetworkInfo {
  static final Connectivity _connectivity = Connectivity();

  static Future<bool> get isConnected async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.none);
  }

  static void checkConnectivity(BuildContext context) {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (Get.find<SplashController>().firstTimeConnectionCheck) {
          Get.find<SplashController>().setFirstTimeConnectionCheck(false);
        } else {
          bool isConnected = !result.contains(ConnectivityResult.none);
          if (!context.mounted) return;
          if (isConnected) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: !isConnected ? Colors.red : Colors.green,
            duration: Duration(seconds: !isConnected ? 6000 : 3),
            content: Text(
              !isConnected ? 'no_connection'.tr : 'connected'.tr,
              textAlign: TextAlign.center,
            ),
          ));
        }
      },
    );
  }

  static Future<XFile> compressImage(XFile file) async {
    final ImageFile input = ImageFile(filePath: file.path, rawBytes: await file.readAsBytes());
    final Configuration config = Configuration(
      outputType: ImageOutputType.webpThenPng,
      useJpgPngNativeCompressor: false,
      quality: (input.sizeInBytes / 1048576) < 2
          ? 90
          : (input.sizeInBytes / 1048576) < 5
              ? 50
              : (input.sizeInBytes / 1048576) < 10
                  ? 10
                  : 1,
    );
    final ImageFile output = await compressor.compress(ImageFileConfiguration(input: input, config: config));
    if (kDebugMode) {
      log('Input size : ${input.sizeInBytes / 1048576}');
      log('Output size : ${output.sizeInBytes / 1048576}');
    }
    return XFile.fromData(output.rawBytes);
  }
}
