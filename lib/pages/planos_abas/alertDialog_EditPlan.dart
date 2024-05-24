import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/modules/config/component/PlansModel.dart';
import 'package:painel_velocitynet/modules/config/model/category_model.dart';
import 'package:painel_velocitynet/modules/create_complementos/complementos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertDialogEditPlan extends StatefulWidget {
  final PlansModel plans;
  const AlertDialogEditPlan({super.key, required this.plans});

  @override
  State<AlertDialogEditPlan> createState() => _AlertDialogEditPlanState();
}

class _AlertDialogEditPlanState extends State<AlertDialogEditPlan> {
  late TextEditingController nomePlano =
      TextEditingController(text: widget.plans.nome);
  late TextEditingController descricao =
      TextEditingController(text: widget.plans.descricao);
  late TextEditingController valor = TextEditingController(
      text: 'R\$ ${widget.plans.preco.replaceAll(RegExp(r'[^\d.]'), '')}');
  late String? selectedValue = widget.plans.idCategoria;

  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  String formatCurrency(String value) {
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');
    double parsedValue = double.tryParse(cleanedValue)! / 100;
    return _currencyFormat.format(parsedValue);
  }

  bool isChecked = false;

  Future<String> getTokenFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }

  List<PlansModel> plans = [];
  List<CategoryModel> category = [];
  List<dynamic> categoryPlans = [];
  Future<void> CategoryPlans() async {
    try {
      final token = await getTokenFromLocalStorage();
      final response = await http.get(
        Uri.parse('${ApiContants.baseApi}/category-plan'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          categoryPlans = data;
        });
      } else {
        print('Erro ao buscar dados: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao realizar requisição: $e');
    }
  }

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

  FilePickerResult? resultBase;
  late Uint8List resultBytesBase;
  uploadImageBase() async {
    resultBase = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (resultBase != null) {
      setState(() {
        resultBytesBase = resultBase!.files.first.bytes!;
      });
    }
  }

  updatePlans(
    String id,
    String nome,
    String descricao,
    String idCategoria,
    List<Map<String, String>> complementar,
    String preco,
    String token,
  ) async {
    try {
      var request = http.MultipartRequest(
        "PATCH",
        Uri.parse('${ApiContants.baseApi}/plans/update'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      if (resultBase != null && resultBytesBase.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'images',
            resultBytesBase,
            filename: resultBase!.files.first.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
      if (result != null && resultBytes.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'images',
            resultBytes,
            filename: result!.files.first.name,
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
      String complementarJson = jsonEncode(complementar);

      request.fields.addAll({
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'idCategoria': idCategoria,
        'complementar': complementarJson,
        'preco': preco,
      });

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Plano atualizado com sucesso.');
      } else {
        print('Erro ao atualizar plano: ${response.statusCode}');
      }
    } catch (error) {
      print("Erro na requisição: $error");
      return null;
    }
  }

  List<dynamic> dataComplemento = [];
  Future<void> getComplemento() async {
    final token = await getTokenFromLocalStorage();
    final response = await http.get(
      Uri.parse('${ApiContants.baseApi}/complement'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        dataComplemento = responseData
            .map((json) => CreateComplementoModel.fromJson(json))
            .toList();
      });
    } else {
      print('Erro ao buscar dados: ${response.statusCode}');
    }
  }

  void toggleCheckAll(bool? value) {
    setState(() {
      isChecked = value!;
      for (var item in dataComplemento) {
        item.isChecked = isChecked;
      }
    });
  }

  bool _isImageSelected() {
    return result != null;
  }

  bool _isImageSelectedBase() {
    return resultBase != null;
  }

  @override
  void initState() {
    super.initState();
    CategoryPlans();
    getComplemento();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(
          textAlign: TextAlign.center,
          'Atualizar Plano',
          style: GoogleFonts.getFont('Poppins',
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xff3D3D3D),
        actions: <Widget>[
          SizedBox(
            width: 600,
            height: 480,
            child: Row(
              children: [
                resultBase == null
                    ? InkWell(
                        onTap: () {
                          uploadImageBase();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          width: 220,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "${ApiContants.baseApi}/uploads/${widget.plans.planoBase}",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: 220,
                        height: 490,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            resultBytesBase,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          result == null
                              ? InkWell(
                                  onTap: () {
                                    uploadImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 150,
                                    height: 150,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "${ApiContants.baseApi}/uploads/${widget.plans.imagem}",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      resultBytes,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Nome do Plano',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff5F5F5F),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 30,
                                  width: 240,
                                  child: TextFormField(
                                    controller: nomePlano,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                    decoration: const InputDecoration(
                                        hintText: 'Plano Connect - 500Mbps',
                                        hintStyle: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xffCFCFCF)),
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 10),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                                Text(
                                  'Descrição',
                                  style: GoogleFonts.getFont('Poppins',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff5F5F5F),
                                  ),
                                  height: 30,
                                  width: 240,
                                  child: TextFormField(
                                    controller: descricao,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    decoration: const InputDecoration(
                                        hintText:
                                            'Melhor preço, melhor estabilidade, melhor co...',
                                        hintStyle: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xffCFCFCF)),
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 10),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Categoria',
                                          style: GoogleFonts.getFont('Poppins',
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff5F5F5F),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color(0xff5F5F5F),
                                              )),
                                              isExpanded: true,
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_outlined,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              hint: const Text(
                                                'Select',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white),
                                              ),
                                              items: categoryPlans
                                                  .map((dynamic category) {
                                                return DropdownMenuItem<String>(
                                                  value: category['_id']
                                                      .toString(),
                                                  child: Text(
                                                    category['nome'],
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white),
                                                  ),
                                                );
                                              }).toList(),
                                              value: selectedValue,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedValue = value;
                                                });
                                              },
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                height: 30,
                                                width: 110,
                                              ),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Valor do Plano',
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0xff5F5F5F),
                                          ),
                                          height: 30,
                                          width: 90,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              final formattedValue =
                                                  formatCurrency(value);
                                              valor.value = TextEditingValue(
                                                text: formattedValue,
                                                selection:
                                                    TextSelection.collapsed(
                                                  offset: formattedValue.length,
                                                ),
                                              );
                                            },
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            controller: valor,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                            decoration: const InputDecoration(
                                                hintText: 'R\$ 99,99',
                                                hintStyle: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xffCFCFCF)),
                                                contentPadding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 10),
                                                border: OutlineInputBorder(
                                                    borderSide:
                                                        BorderSide.none)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 410,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Informações Complementares',
                              style: GoogleFonts.getFont('Poppins',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Geral',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Marcar todos',
                                        style: GoogleFonts.getFont('Poppins',
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Checkbox(
                                        checkColor: Colors.white,
                                        side: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 128, 128, 128),
                                        ),
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                                Color(0xff5F5F5F)),
                                        value: isChecked,
                                        onChanged: toggleCheckAll,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: dataComplemento.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.network(
                                                      fit: BoxFit.cover,
                                                      '${ApiContants.baseApi}/uploads/${dataComplemento[index].imageComplemento}'),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                dataComplemento[index]
                                                    .nomeComplemento,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Checkbox(
                                            checkColor: Colors.white,
                                            side: const BorderSide(
                                              width: 2,
                                              color: Color.fromARGB(
                                                  255, 128, 128, 128),
                                            ),
                                            fillColor:
                                                const MaterialStatePropertyAll(
                                                    Color(0xff5F5F5F)),
                                            value: dataComplemento[index]
                                                .isChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                dataComplemento[index]
                                                    .isChecked = value!;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 415,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deste Plano',
                              style: GoogleFonts.getFont('Poppins',
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  '+ Novo Complemento',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 415,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                Text(
                                  'Instalação R\$ 100,00',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              side: const BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 128, 128, 128),
                              ),
                              fillColor: const MaterialStatePropertyAll(
                                  Color(0xff5F5F5F)),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 190,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: const Text(
                                    'Fechar',
                                    style: TextStyle(color: Color(0xff6F6F6F)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 190,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(20),
                                  ),
                                  onPressed: () async {
                                    String precoFormatado = valor.text
                                        .replaceAll('R\$ ', '')
                                        .replaceAll('.', '')
                                        .replaceAll(',', '.');

                                    List<Map<String, String>> complementar =
                                        dataComplemento
                                            .where((comp) => comp.isChecked)
                                            .map((comp) => {
                                                  "id": comp.idComplemento
                                                      .toString()
                                                })
                                            .toList();
                                    final token =
                                        await getTokenFromLocalStorage();
                                    updatePlans(
                                        widget.plans.idSimulador,
                                        nomePlano.text,
                                        descricao.text,

                                        // widget.plans.idCategoria,
                                        valor.text,
                                        complementar,
                                        token,
                                        precoFormatado);
                                    //                                        String id,
                                    // String nome,
                                    // String descricao,
                                    // String idCategoria,
                                    // List<Map<String, String>> complementar,
                                    // String preco,
                                    // String token,
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            'Plano cadastrado com sucesso!'),
                                      ),
                                    );
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text(
                                    'Atualizar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
