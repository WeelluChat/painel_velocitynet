import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/tv_classes/item_tv.dart';

class TV extends StatefulWidget {
  const TV({super.key});

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  late ItemTv itemTv = ItemTv(
      id: id, titulo: titulo.text, decricao: descricao.text, valor: valor.text);
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();
  late String id;

  List<ItemTv> dadosTV = [];

  Future receberDadosTv() async {
    Uri url = Uri.parse('http://10.0.0.149:3000/api/v1/tv');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<ItemTv> tv =
          decodedData.map((item) => ItemTv.fromJson(item)).toList();

      if (tv.isNotEmpty) {
        titulo.text = tv[0].titulo;
        descricao.text = tv[0].decricao;
        valor.text = tv[0].valor;
        id = tv[0].id;
      }

      setState(() {
        dadosTV = tv;
      });
    } else {
      if (kDebugMode) {
        print(
            'Erro ao buscar os dados das ofertas. Código de status: ${response.statusCode}');
      }
    }
  }

  Future atualizarDadosTv(String id, String novoTitulo, String novaDescricao,
      String novoValor) async {
    Uri url = Uri.parse('http://10.0.0.149:3000/api/v1/tv');

    Map<String, String> body = {
      'id': id,
      'title': novoTitulo,
      'description': novaDescricao,
      'value': novoValor
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response =
        await http.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      receberDadosTv();
    } else {
      if (kDebugMode) {
        print(
            'Erro ao atualizar os dados da tv, Status code: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    receberDadosTv();
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
                    0xff292929,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Gerenciamento de configurações',
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
                      height: 55,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 900,
                        // color: Colors.red,
                        child: ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Título',
                                  style: GoogleFonts.getFont('Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 61,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff3D3D3D),
                                  ),
                                  width: 912,
                                  child: TextField(
                                    controller: titulo,
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
                                const SizedBox(height: 16),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Descrição',
                                  style: GoogleFonts.getFont('Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 61,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff3D3D3D),
                                  ),
                                  width: 912,
                                  child: TextField(
                                    controller: descricao,
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
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Valor',
                                  style: GoogleFonts.getFont('Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 61,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff3D3D3D),
                                  ),
                                  width: 500,
                                  child: TextField(
                                    controller: valor,
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
                              ],
                            ),
                            const SizedBox(
                              height: 51,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width < 600
                                          ? 51
                                          : 61,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.only(left: 20, right: 20)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff46964A)),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Adicionar imagem',
                                      style: GoogleFonts.getFont('Poppins',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Center(
                              child: Container(
                                height: MediaQuery.of(context).size.width < 800
                                    ? 51
                                    : 61,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.only(left: 70, right: 70)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff46964A)),
                                  ),
                                  onPressed: () {
                                    atualizarDadosTv(id, titulo.text,
                                        descricao.text, valor.text);
                                  },
                                  child: Text(
                                    'Salvar',
                                    style: GoogleFonts.getFont('Poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
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
