import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/helpers/token.dart';
import 'package:painel_velocitynet/modules/create_complementos/complementos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Complementos extends StatefulWidget {
  const Complementos({super.key});

  @override
  State<Complementos> createState() => _ComplementosState();
}

class _ComplementosState extends State<Complementos> {
  String? selectedImage;
  List<CreateComplementoModel> dataComplementoModel = [];
  TextEditingController nomeComplemento = TextEditingController();
  FilePickerResult? result;
  late Uint8List resultBytes;
  uploadImage() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        resultBytes = result!.files.first.bytes!;
      });
    }
  }

  createComplemento(
    nome,
    token,
  ) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse('${ApiContants.baseApi}/additional-information/create'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          resultBytes,
          filename: result!.files.first.name,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.fields.addAll({
        'nome': nome,
      });

      await request.send();
    } catch (error) {
      print("Erro na requisição: $error");
      return null;
    }
  }

  Future<String> getTokenFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }

  List<dynamic> dataComplemento = [];
  Future<void> getComplemento() async {
    final token = await getTokenFromLocalStorage();
    final response = await http.get(
      Uri.parse('${ApiContants.baseApi}/additional-information'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        print('Conexão feita com sucesso');
        dataComplemento = json.decode(response.body);
      });
    } else {
      print('Erro ao buscar dados: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComplemento();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Complementos',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    uploadImage();
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white),
                      ),
                      child: result == null
                          ? const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.white,
                                )
                              ],
                            )
                          : SizedBox(
                              width: 130,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  resultBytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff5F5F5F),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 50,
                    width: 400,
                    child: TextFormField(
                      controller: nomeComplemento,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: 'Ex: Instalação grátis',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Color(0xffCFCFCF)),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(23),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  onPressed: () async {
                    createComplemento(nomeComplemento.text,
                        await GetToken().getTokenFromLocalStorage());

                    nomeComplemento.clear();
                  },
                  child: const Text(
                    'Enviar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: dataComplemento.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 5, bottom: 5),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(
                          0xff2F2F2F,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  dataComplemento[index]['nome'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: Colors.green),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Editar',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
