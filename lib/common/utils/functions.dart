import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/network/api_services.dart';

class Functions {
  static Future<String> getImageFilePathFromAssets(
    String asset,
    String filename,
  ) async {
    final byteData = await rootBundle.load(asset);
    final tempdireactory = await getTemporaryDirectory();
    final file = File('${tempdireactory.path}/$filename');
    await file.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    return file.path;
  }

  static Future<String> downloadFile(String URL, String filename) async {
    final direactory = await getApplicationSupportDirectory();
    final filepath = '${direactory.path}/$filename';
    final response = await ApiServices().downloadFile(
      URL,
      filepath,
      CancelToken(),
    );
    print(response);
    if (response.isSuccess && response.data != null) {
      final file = File(filepath);
      await file.writeAsBytes(response.data);
    }
    return filepath;
  }
}
