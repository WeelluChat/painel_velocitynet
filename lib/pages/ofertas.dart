import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/ofertas_classes/item.dart';

class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
  late Item itemApi = Item(
      id: id, titulo: titulo.text, decricao: descricao.text, valor: valor.text);
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController textoPreco = TextEditingController();
  late String id;

  List<Item> dadosOfertas = [];

  Future receberDadosOfertas() async {
    Uri url = Uri.parse('${ApiContants.baseApi}/offer');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<Item> ofertas =
          decodedData.map((item) => Item.fromJson(item)).toList();

      if (ofertas.isNotEmpty) {
        titulo.text = ofertas[0].titulo;
        descricao.text = ofertas[0].decricao;
        valor.text = ofertas[0].valor;
        id = ofertas[0].id;
      }

      setState(() {
        dadosOfertas = ofertas;
      });
    } else {
      if (kDebugMode) {
        print(
            'Erro ao buscar os dados das ofertas. Código de status: ${response.statusCode}');
      }
    }
  }

  Future atualizarDadosOfertas(
    String id,
    String novoTitulo,
    String novaDescricao,
    String novoValor,
  ) async {
    Uri url = Uri.parse('${ApiContants.baseApi}/offer');

    Map<String, String> body = {
      'id': id,
      'title': novoTitulo,
      'description': novaDescricao,
      'value': novoValor,
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    http.Response response =
        await http.patch(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Dados da oferta atualizados com sucesso!');
      }
      if (kDebugMode) {
        print(response.body);
      }
      receberDadosOfertas();
    } else {
      if (kDebugMode) {
        print(
            'Erro ao atualizar os dados da oferta. Status code: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    receberDadosOfertas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      // color: Colors.pinkAccent,
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
                  ),),
                child: Column(
                  children: [
                    Text(
                      'Gerenciamento de ofertas',
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
                                          EdgeInsets.only(left: 20, right: 20, top:15)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(10),),),
                                      backgroundColor:
                                           MaterialStateProperty.all(
                                              const Color(0xff181919)),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add, size: 45),
                                        Text(
                                          textAlign: TextAlign.center,
                                          'Adicionar imagem',
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                  width: double.infinity,
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
                                  width: double.infinity,
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 61,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: const Color(0xff3D3D3D),
                                        ),
                                        width: 950,
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
                                    ),
                                    const SizedBox(width: 20,),
                                    Container(
                              height: MediaQuery.of(context).size.width < 800
                                  ? 61
                                  : 61,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.only(left: 40, right: 40)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff46964A)),
                                ),
                                onPressed: () {
                                  atualizarDadosOfertas(id, titulo.text,
                                      descricao.text, valor.text);
                                },
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Salvar',

                                  style: GoogleFonts.getFont('Poppins',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                                  ],
                                ),
                              ],
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

                         
                          
                        
                          //  SizedBox(
                          //   height: MediaQuery.of(context).size.width < 600 ? 20 : 61,
                          // ),
                          