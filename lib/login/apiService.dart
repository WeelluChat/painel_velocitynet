import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/constantes/api_url.dart';

class ApiService {
  static Future<void> fazerRequisicaoAutenticada(String token) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        Uri.parse("${ApiRotaAuthLogin.rotaAuthLogin}/login"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print("Token: $token");
      } else {
        print("Erro na API: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro ao fazer a requisição: $e");
    }
  }
}