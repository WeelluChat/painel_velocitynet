import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/login/auth_maneger.dart';
import 'package:painel_velocitynet/login/auth_service.dart';
import 'package:painel_velocitynet/login/api_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controlerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  late AuthService authService = AuthService(
      controlerEmail: controlerEmail,
      controllerPassword: controllerPassword,
      context: context);
  late ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: SizedBox(
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 640,
              width: 550,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 40),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 8,
                      color: const Color(0xff46964A),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E-mail',
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffF5F5F5),
                          ),
                          width: double.infinity,
                          child: TextField(
                            controller: controlerEmail,
                            // obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintText: 'Example@gmail.com',
                              hintStyle: GoogleFonts.getFont('Poppins',
                                  color: const Color(0xff969696),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Senha',
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF5F5F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: double.infinity,
                          height: 65,
                          child: TextField(
                            controller: controllerPassword,
                            obscureText: true,
                            decoration: InputDecoration(
                              fillColor: Colors.red,
                              hintText: '••••••••••••••••',
                              hintStyle: GoogleFonts.getFont('Poppins',
                                  color: const Color(0xff969696),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          height: 65,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff46964A)),
                            ),
                            onPressed: () async {
                              // print(controlerEmail.text);
                              // print(controllerPassword.text);
                              await authService
                                  .autentication(); // Espera a autenticação ser concluída
                              final token = await AuthManager
                                  .getToken(); // Obtém o token armazenado
                              if (token != null) {
                                ApiService.fazerRequisicaoAutenticada(token);
                              }
                            },
                            child: Text(
                              'Entrar',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class AuthManager {
//   static const String _tokenKey = 'token';

//   static Future<void> setToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }

//   static Future<void> clearToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_tokenKey);
//   }
// }




 // Future<void> autentication() async {
  //   var parse = Uri.parse("${ApiRotaAuthLogin.rotaAuthLogin}/auth/login");
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   Map<String, String> body = {
  //     'email': controlerEmail.text,
  //     'password': controllerPassword.text,
  //   };

  //   http.Response response =
  //       await http.post(parse, headers: headers, body: jsonEncode(body));
  //   if (response.statusCode == 200) {
  //     // print('Resposta da API: ${response.body}');
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     final String token = responseData['token'];
  //     await AuthManager.setToken(token);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const MyTabbedPanel(),
  //       ),
  //     );
  //     controlerEmail.clear();
  //     controllerPassword.clear();
  //     fazerRequisicaoAutenticada(token);
  //   } else if (response.statusCode == 404) {
  //     final snackBar = SnackBar(
  //       backgroundColor: Colors.red,
  //       content: const Text('Usuário não cadastrado'),
  //       action: SnackBarAction(
  //         label: 'Close',
  //         textColor: Colors.white,
  //         onPressed: () {},
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else {
  //     print('Erro na API: ${response.statusCode}');
  //   }
  // }

  // Future<void> fazerRequisicaoAutenticada(String token) async {
  //   Map<String, String> headers = {
  //     'Authorization': 'Bearer $token',
  //   };
  //   try {
  //     final response = await http.post(
  //         Uri.parse("${ApiRotaAuthLogin.rotaAuthLogin}/login"),
  //         headers: headers);
  //     if (response.statusCode == 200) {
  //       print("Token: $token");
  //     } else {
  //       print("Erro na API: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Erro ao fazer a requisição: $e");
  //   }
  // }
