import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatePlans extends StatefulWidget {
  const CreatePlans({super.key});

  @override
  State<CreatePlans> createState() => _CreatePlansState();
}

class _CreatePlansState extends State<CreatePlans> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        textAlign: TextAlign.center,
        'Criar plano',
        style: GoogleFonts.getFont('Poppins',
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
      ),
      backgroundColor: const Color(0xff3D3D3D),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          width: 670,
          height: 570,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 550,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          'Adicionar\nimagem plano base',
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 170,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Adicionar\nimagem de cabeçalho',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Nome do Plano',
                                style: GoogleFonts.getFont('Poppins',
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff5F5F5F),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 30,
                                width: 220,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                  decoration: const InputDecoration(
                                      hintText: 'Plano Connect - 500Mbps',
                                      hintStyle: TextStyle(
                                          fontSize: 12,
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff5F5F5F),
                                ),
                                height: 30,
                                width: 220,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  decoration: const InputDecoration(
                                      hintText:
                                          'Melhor preço, melhor estabilidade, melhor co...',
                                      hintStyle: TextStyle(
                                          fontSize: 12,
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
                                'Valor do Plano',
                                style: GoogleFonts.getFont('Poppins',
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff5F5F5F),
                                ),
                                height: 30,
                                width: 90,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  decoration: const InputDecoration(
                                      hintText: 'R\$ 99,99',
                                      hintStyle: TextStyle(
                                          fontSize: 12,
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
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 415,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informações Complementos',
                              style: GoogleFonts.getFont('Poppins',
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Geral',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
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
                                        color: Color(0xff5F5F5F),
                                      ),
                                      fillColor: const MaterialStatePropertyAll(
                                          Colors.transparent),
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Instalação grátis',
                                      style: GoogleFonts.getFont('Poppins',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xff5F5F5F),
                                  ),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Extensor Smash',
                                      style: GoogleFonts.getFont('Poppins',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xff5F5F5F),
                                  ),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Ultra Cobertura Wi-fi 5',
                                      style: GoogleFonts.getFont('Poppins',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xff5F5F5F),
                                  ),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      '+60 Canais TV',
                                      style: GoogleFonts.getFont('Poppins',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                    width: 2,
                                    color: Color(0xff5F5F5F),
                                  ),
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.transparent),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 415,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Deste Plano',
                              style: GoogleFonts.getFont('Poppins',
                                  fontSize: 16,
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
                                ),
                                Text(
                                  'Instalação R\$ 100,00',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Checkbox(
                              checkColor: Colors.white,
                              side: const BorderSide(
                                width: 2,
                                color: Color(0xff5F5F5F),
                              ),
                              fillColor: const MaterialStatePropertyAll(
                                  Colors.transparent),
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
                      const SizedBox(
                        height: 55,
                      ),
                      SizedBox(
                        width: 415,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
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
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.all(20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
