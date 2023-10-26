import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/ofertas_classes/Item.dart';

class Ofertas extends StatefulWidget {
  const Ofertas({super.key});

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {

  late Item itemApi = Item(id: id, titulo: titulo.text, decricao: descricao.text, valor: valor.text);
  TextEditingController titulo = TextEditingController();
  TextEditingController descricao = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController textoPreco = TextEditingController();
  late String id;

  List<Item> dadosOfertas = [];

  Future receberDadosOfertas() async {
    Uri url = Uri.parse('http://10.0.0.149:3000/api/v1/offer');
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
      print(
          'Erro ao buscar os dados das ofertas. Código de status: ${response.statusCode}');
    }
  }

  Future atualizarDadosOfertas(String id, String novoTitulo, String novaDescricao,
      String novoValor, ) async {
    Uri url = Uri.parse('http://10.0.0.149:3000/api/v1/offer');

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
      print('Dados da oferta atualizados com sucesso!');
      print(response.body);
      receberDadosOfertas();
    } else {
      print(
          'Erro ao atualizar os dados da oferta. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receberDadosOfertas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(
                0xff292929,
              ),
            ),
            child: SizedBox(
              width: 1200,
              height: 800,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Gerenciamento de configurações',
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Título',
                      style: GoogleFonts.getFont('Poppins',
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
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
                          fillColor: Colors.red,
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
                      height: 30,
                    ),
                    Text(
                      'Descrição',
                      style: GoogleFonts.getFont('Poppins',
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
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
                          fillColor: Colors.red,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Valor',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 60,
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
                                  fillColor: Colors.red,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Texto preço',
                                  style: GoogleFonts.getFont('Poppins',
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff3D3D3D),
                                  ),
                                  width: 500,
                                  child: TextField(
                                    controller: textoPreco,
                                    style: const TextStyle(color: Colors.white),
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                      fillColor: Colors.red,
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
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      width: 250,
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
                          'Adicionar imagem',
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 65,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xff46964A)),
                            ),
                            onPressed: () {
                              atualizarDadosOfertas(
                                  id, titulo.text, descricao.text, valor.text);
                            },
                            child: Text(
                              'Salvar',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

