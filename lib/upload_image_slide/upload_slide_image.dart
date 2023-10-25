import 'dart:html' as html;
class UploadImage{
  Future<void> selectImageGaleria() async {
    final inputFile = html.FileUploadInputElement();
    inputFile.accept =
        'image/*';
    inputFile.click(); 

    inputFile.onChange.listen((e) {
      final selectedFile = inputFile.files?.first;
      if (selectedFile != null) {
        final imageUrl = html.Url.createObjectUrl(selectedFile);
      }
    });
  }
}

