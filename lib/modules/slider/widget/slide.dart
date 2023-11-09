import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/service/slider/api_slider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Slide extends StatefulWidget {
  const Slide({super.key});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  //função para converter a data limite e retornar true ou false caso a data limite for excedida
  bool dataLimite(String dataLimite) {
    final dataAtual = DateTime.now();
    final limitDate = DateFormat('dd/MM/yyyy').parse(dataLimite);
    return dataAtual.isAfter(limitDate);
  }

  DateTime _dateTime = DateTime.now();
  //FUNÇÃO PARA ATUALIZAR A DATA DE CADA ITEM DO JSON
  Future<void> atualizarDataSlider(
      String itemId, String novaData, String token) async {
    Uri url = Uri.parse('${ApiContants.baseApi}/slider');
    novaData = DateFormat('dd/MM/yyyy').format(_dateTime);

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode({"id": itemId, "date": novaData}),
      );
      if (response.statusCode == 200) {
        print('DataSlider do item $itemId atualizado com sucesso!');
      } else {
        print(
            'Erro ao atualizar DataSlider do item $itemId, status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Erro ao atualizar DataSlider do item $itemId: $error');
    }
  }

  //FUNÇÃO PARA ABRIR O CALENDARIO
  _showDatePicker(int index) {
    showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) async {
      if (value != null) {
        setState(() {
          _dateTime = value;
        });

        final token = await getTokenFromLocalStorage();
        final itemId = dados[index]['_id'];
        final novaData = _dateTime.toString();
        atualizarDataSlider(itemId, novaData, token);
      }
    });
  }

  //PEGAR O TOKEN DO LOCAL STORAGE
  List<dynamic> dados = [];
  Future<String> getTokenFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }

  //GET PARA RECEBER OS DADOS DA API SLIDER-ALL
  Future getSlide() async {
    Uri url = Uri.parse("${ApiContants.baseApi}/slider-all");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        dados = jsonDecode(response.body);
      });
    }
  }

  void deleteItem(String itemId, String token) async {
    final url = Uri.parse("${ApiContants.baseApi}/slider");

    try {
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
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

  // Future atualizarImagem(
  //   String id,
  // ) async {
  //   Uri url = Uri.parse('${ApiContants.baseApi}/slider');

  //   Map<String, String> body = {
  //     'id': id,
  //   };
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //   };

  //   http.Response response =
  //       await http.patch(url, headers: headers, body: jsonEncode(body));
  //   if (response.statusCode == 200) {
  //     print('A imagem foi atualizada com sucesso!');
  //     print(response.body);
  //   } else {
  //     print('Erro ao atualizar a imagem. Status code: ${response.statusCode}');
  //   }
  // }
  @override
  void initState() {
    super.initState();
    getSlide();
    // formatDate(formatarData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.start,
        direction: Axis.vertical,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 1416,
                height: 802,
                padding: const EdgeInsets.only(
                  top: 27,
                  bottom: 50,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(
                    0xff181919,
                  ),
                  // color: Colors.cyan,
                ),
                child: Column(
                  children: [
                    Text(
                      'Gerenciamento de slides',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize:
                            MediaQuery.of(context).size.width < 800 ? 22 : 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 1200,
                        // color: Colors.red,
                        child: ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 1200,
                                  height:
                                      MediaQuery.of(context).size.width < 600
                                          ? 51
                                          : 90,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.only(
                                              left: 20, right: 20, top: 15)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff181919)),
                                    ),
                                    onPressed: () async {
                                      final token =
                                          await getTokenFromLocalStorage();
                                      ApiSlider().uploadImage("slider", token);
                                      getSlide();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add, size: 45),
                                        Text(
                                          maxLines: 2,
                                          'Adicionar imagem',
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            // Text(DateFormat('dd/MM/yyyy').format(_dateTime),
                            //     style: const TextStyle(
                            //         color: Colors.white, fontSize: 22)),
                            SizedBox(
                              height: 800,
                              // color: Colors.cyan,
                              child: GridView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: dados.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                // onReorder: (int oldIndex, int newIndex) {
                                //   setState(() {
                                //     if (oldIndex < newIndex) {
                                //       newIndex -= 1;
                                //     }
                                //     final item = dados.removeAt(oldIndex);
                                //     dados.insert(newIndex, item);
                                //   });
                                // },
                                itemBuilder: (context, index) {
                                  final imageUrl = dados[index]['name'];
                                  return Column(
                                    key: Key(imageUrl),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          color: Colors.green,
                                          width: 300,
                                          child: Image.network(
                                            '${ApiContants.baseApi}/uploads/$imageUrl',
                                            errorBuilder: (context, exception,
                                                stackTrace) {
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
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Container(
                                      //   height: 35,
                                      //   width: 300,
                                      //   decoration: const BoxDecoration(
                                      //     borderRadius:
                                      //         BorderRadius.all(Radius.zero),
                                      //     // color: Colors.green
                                      //   ),
                                      //   child: ElevatedButton(
                                      //     style: ButtonStyle(
                                      //       shape: MaterialStateProperty.all(
                                      //           RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       10))),
                                      //       backgroundColor:
                                      //           MaterialStateProperty.all(
                                      //               const Color(0xFF4D73F1)),
                                      //     ),
                                      //     onPressed: () {

                                      //     },
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         PhosphorIcon(
                                      //           PhosphorIcons.regular.pencil,
                                      //           color: Colors.white,
                                      //           size: 25,
                                      //         ),
                                      //         const SizedBox(
                                      //           width: 10,
                                      //         ),
                                      //         Text(
                                      //           'Selecionar imagem',
                                      //           style: GoogleFonts.getFont(
                                      //               'Poppins',
                                      //               color: Colors.white,
                                      //               fontSize: 15,
                                      //               fontWeight:
                                      //                   FontWeight.w500),
                                      //         ),
                                      //         const SizedBox(
                                      //           width: 20,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 280,
                                        decoration: const BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero),
                                          // color: Colors.green
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              dataLimite(dados[index]
                                                      ['dateSlider'])
                                                  ? const Color(0xffF14D4D)
                                                  : const Color(0xff008d69),
                                            ),
                                          ),
                                          onPressed: () async {
                                            final token =
                                                await getTokenFromLocalStorage();
                                            final itemId = dados[index]['_id'];
                                            final selectedDate =
                                                _showDatePicker(index);
                                            if (selectedDate != null) {
                                              final novaData =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(selectedDate);

                                              atualizarDataSlider(
                                                  itemId, novaData, token);
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              PhosphorIcon(
                                                PhosphorIcons.regular.alarm,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                dados[index]['dateSlider'],
                                                style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                        width: 280,
                                        decoration: const BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero),
                                          // color: Colors.green
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0xffF14D4D)),
                                          ),
                                          onPressed: () async {
                                            final token =
                                                await getTokenFromLocalStorage();
                                            final itemId = dados[index]['_id'];
                                            deleteItem(itemId, token);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                width: 35,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
