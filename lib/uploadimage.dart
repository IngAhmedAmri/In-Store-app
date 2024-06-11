// lib/utils.dart

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> uploadImage(File imageFile) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'YOUR_SERVER_UPLOAD_ENDPOINT'), // Replace with your server endpoint
  );
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  var res = await request.send();

  if (res.statusCode == 200) {
    final resStr = await res.stream.bytesToString();
    final imageUrl = jsonDecode(
        resStr)['url']; // Assuming the response contains the image URL
    return imageUrl;
  } else {
    throw Exception('Failed to upload image');
  }
}
