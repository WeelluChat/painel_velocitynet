import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/constantes/api_url.dart';

class ApiSlider {
  Future uploadImage(String route, String token) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes?.toList();
      final fileName = result.files.first.name;

      var request = http.MultipartRequest(
          'POST', Uri.parse("${ApiContants.baseApi}/$route"));
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(http.MultipartFile.fromBytes('image', fileBytes!,
          filename: fileName));

      try {
        await request.send();
      } catch (e) {
        if (kDebugMode) {
          print('Erro ao enviar a imagem: $e');
        }
      }
    }
  }
}
