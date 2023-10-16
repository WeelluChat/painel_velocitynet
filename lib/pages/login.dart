import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                            onPressed: () {},
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
