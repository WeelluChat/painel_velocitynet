import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/service/slider/api_slider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  List<dynamic> dados = [];

  Future<void> getSlide() async {
    Uri url = Uri.parse("${ApiContants.baseApi}/plans");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        dados = jsonDecode(response.body);
      });
    }
  }

  void deleteItem(String itemId) async {
    final url = Uri.parse("${ApiContants.baseApi}/plans");

    try {
      final response = await http.delete(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": itemId}),
      );

      if (response.statusCode == 200) {
        getSlide();
      } else {
        if (kDebugMode) {
          print('Erro ao excluir o item: ${response.statusCode}');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Erro na solicitação DELETE: $error');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSlide();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pinkAccent,
      child: Padding(
        padding: const EdgeInsets.only(right: 40, bottom: 30, top: 10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(
                    0xff292929,
                  ),
                  // color: Colors.amber
                ),
                child: SizedBox(
                
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                maxLines: 2,
                                'Gerenciamento de configurações',
                                style: GoogleFonts.getFont('Poppins',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Título',
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff3D3D3D),
                          ),
                          width: double.infinity,
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            // obscureText: true,
                            decoration: InputDecoration(
                              // fillColor: Colors.red,
                              hintText: '',
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
                        Container(
                          height: 45,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          width: 100,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff46964A)),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Salvar',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                          //  color: Colors.green,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dados.length,
                              itemBuilder: (context, index) {
                                final imageUrl = dados[index]['name'];
                                return Container(
                                  // color: Colors.cyan,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          // color: Colors.amber,
                                          height: 290,
                                          child: Image.network(
                                            'http://10.0.0.149:3000/api/v1/uploads/$imageUrl',
                                            width: 290,
                                            errorBuilder:
                                                (context, exception, stackTrace) {
                                              if (kDebugMode) {
                                                print(
                                                    'Erro ao carregar imagem: $exception');
                                              }
                                              return const Text(
                                                  'Erro ao carregar imagem');
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.zero),
                                          // color: Colors.green
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10))),
                                            backgroundColor: MaterialStateProperty.all(
                                                const Color(0xFF4D73F1)),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PhosphorIcon(
                                                PhosphorIcons.regular.pencil,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Selecionar imagem',
                                                style: GoogleFonts.getFont('Poppins',
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.zero),
                                          // color: Colors.green
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(10))),
                                            backgroundColor: MaterialStateProperty.all(
                                                const Color(0xffF14D4D)),
                                          ),
                                          onPressed: () {
                                            final itemId = dados[index]['_id'];
                                            deleteItem(itemId);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              PhosphorIcon(
                                                PhosphorIcons.regular.trash,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                'Deletar imagem',
                                                style: GoogleFonts.getFont('Poppins',
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 35,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff46964A)),
                            ),
                            onPressed: () {
                              ApiSlider().uploadImage("plans");
                            },
                            child: Text(
                              maxLines: 2,
                              'Adicionar Imagem',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
