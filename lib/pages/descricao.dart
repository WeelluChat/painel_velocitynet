import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/modules/description_item/description_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Planos extends StatefulWidget {
  const Planos({super.key});

  @override
  State<Planos> createState() => _PlanosState();
}

class _PlanosState extends State<Planos> {
  late ItemDescription itemApi =
      ItemDescription(id: id, titulo: titulo.text, texto: texto.text);

  TextEditingController titulo = TextEditingController();
  TextEditingController texto = TextEditingController();

  TextEditingController postTitulo = TextEditingController();
  TextEditingController postTexto = TextEditingController();

  late String id;
  List<ItemDescription> dadosDescription = [];
  Future<String> getTokenFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }

  Future receberDadosDescription() async {
    Uri url = Uri.parse('${ApiContants.baseApi}/card');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      final List<ItemDescription> description =
          decodedData.map((item) => ItemDescription.fromJson(item)).toList();
      setState(
        () {
          dadosDescription = description;
        },
      );
    } else {
      if (kDebugMode) {
        print(
            'Erro ao buscar os dados das ofertas. Código de status: ${response.statusCode}');
      }
    }
  }

  Future<void> deletarItem(String id, String token) async {
    final Uri url = Uri.parse('${ApiContants.baseApi}/card/$id');

    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"_id": id}),
    );
    if (response.statusCode == 200) {
      print(response.body);
      receberDadosDescription();
      setState(() {
        dadosDescription.removeWhere((item) => item.id == id);
      });
    } else {
      if (kDebugMode) {
        print(
            'Erro ao excluir o item. Código de status: ${response.statusCode}');
      }
    }
  }

  void criarCard(String postTitulo, String postTexto, String token) async {
    final Uri url = Uri.parse('${ApiContants.baseApi}/card');
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    final Map<String, dynamic> body = {
      "name": postTitulo,
      "description": postTexto,
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      receberDadosDescription();

      print(response.body);
      print('Conexão realizada com sucesso');
    } else {
      print('Erro ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receberDadosDescription();
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
                  color:const Color(
                    0xff181919,
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
                      height: 25,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 1200,
                        child: ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            Text(
                              'Título',
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.white,
                                  fontSize: 22,
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
                              height: 25,
                            ),
                            Wrap(
                              runSpacing: 20,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width < 600
                                          ? 51
                                          : 50,
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
                                      'Salvar',
                                      style: GoogleFonts.getFont('Poppins',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width < 600
                                          ? 51
                                          : 50,
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
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor:
                                            const Color(0xff343434),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Card',
                                              style: GoogleFonts.getFont(
                                                  'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        content: SizedBox(
                                          height: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'Título',
                                                    style: GoogleFonts.getFont(
                                                        'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xff3D3D3D),
                                                ),
                                                width: 500,
                                                child: TextField(
                                                  controller: postTitulo,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  // obscureText: true,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.red,
                                                    hintText: '',
                                                    hintStyle:
                                                        GoogleFonts.getFont(
                                                            'Poppins',
                                                            color: const Color(
                                                                0xff969696),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Texto',
                                                    style: GoogleFonts.getFont(
                                                        'Poppins',
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xff3D3D3D),
                                                ),
                                                width: 500,
                                                child: TextField(
                                                  controller: postTexto,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  // obscureText: true,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.red,
                                                    hintText: '',
                                                    hintStyle:
                                                        GoogleFonts.getFont(
                                                            'Poppins',
                                                            color: const Color(
                                                                0xff969696),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 20,
                                                bottom: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 65,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.zero),
                                                  ),
                                                  width: 200,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xff46964A)),
                                                    ),
                                                    onPressed: () async {
                                                      final token =
                                                          await getTokenFromLocalStorage();
                                                      criarCard(
                                                          postTitulo.text,
                                                          postTexto.text,
                                                          token);
                                                      Navigator.pop(
                                                          context, 'Criar');
                                                      postTitulo.clear();
                                                      postTexto.clear();
                                                    },
                                                    child: Text(
                                                      'Criar',
                                                      style:
                                                          GoogleFonts.getFont(
                                                              'Poppins',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 65,
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.zero),
                                                  ),
                                                  width: 200,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xff46964A)),
                                                    ),
                                                    onPressed: () async {
                                                      Navigator.pop(
                                                          context, 'Cancelar');
                                                    },
                                                    child: Text(
                                                      'Cancelar',
                                                      style:
                                                          GoogleFonts.getFont(
                                                              'Poppins',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      'Criar card',
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
                              height: 20,
                            ),
                            SizedBox(
                              height: 400,
                              // color: Colors.red,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dadosDescription.length,
                                itemBuilder: (context, index) {
                                  final item = dadosDescription[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xff343434),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                height: 270,
                                                width: 270,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          20.0),
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        item.titulo,
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        textAlign:
                                                            TextAlign.justify,
                                                        item.texto,
                                                        maxLines: 7,
                                                        overflow: TextOverflow.ellipsis,
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
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
                                                width: 270,
                                                decoration:
                                                    const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.zero),
                                                  // color: Colors.green
                                                ),
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(const Color(
                                                                0xffF14D4D)),
                                                  ),
                                                  onPressed: () async {
                                                    final token =
                                                        await getTokenFromLocalStorage();
                                                    await deletarItem(
                                                        item.id, token);
                                                    // deletarItem(item.id);
                                                    // deletarItem(item.id, token);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      PhosphorIcon(
                                                        PhosphorIcons
                                                            .regular.trash,
                                                        color: Colors.white,
                                                        size: 25,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'Deletar card',
                                                        style: GoogleFonts
                                                            .getFont(
                                                                'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
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
                                        ),
                                      ],
                                    ),
                                  );
                                },
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


