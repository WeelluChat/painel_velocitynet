import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/pages/exit.dart';
import 'package:painel_velocitynet/pages/footer.dart';
import 'package:painel_velocitynet/pages/login.dart';
import 'package:painel_velocitynet/modules/offer/widget/offer.dart';
import 'package:painel_velocitynet/pages/descricao.dart';
import 'package:painel_velocitynet/modules/plans/widget/plans.dart';
import 'package:painel_velocitynet/modules/slider/widget/slide.dart';
import 'package:painel_velocitynet/pages/perguntas.dart';
import 'package:painel_velocitynet/pages/tv.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:html' as html;

class MyTabbedPanel extends StatefulWidget {
  const MyTabbedPanel({super.key});

  @override
  MyTabbedPanelState createState() => MyTabbedPanelState();
}

class MyTabbedPanelState extends State<MyTabbedPanel> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Painel - Velocitynet",
              style: GoogleFonts.getFont('Poppins',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Colors.black),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 40, bottom: 50, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width < 1300 ? 200 : 350,
              // height: 800,
              child: NavigationRail(
                backgroundColor: const Color(
                  0xff181919,
                ),
                extended: true,
                selectedIndex: _currentIndex,
                labelType: NavigationRailLabelType.none,
                onDestinationSelected: (int index) {
                  setState(() {
                    _currentIndex = index;
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  });
                },
                destinations: [
                  NavigationRailDestination(
                      icon: Image.asset(
                        'images/slides.png',
                        color: Colors.white,
                        width: 40,
                      ),
                      // PhosphorIcon(
                      //   PhosphorIcons.regular.slideshow,
                      //   size: 25,
                      //   color: const Color(0xff969696),
                      // ),
                      label: Text(
                        'Slide',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                  NavigationRailDestination(
                      icon: Image.asset(
                        'images/plano.png',
                        color: Colors.white,
                        width: 30,
                      ),
                      // icon: PhosphorIcon(
                      //   PhosphorIcons.regular.globe,
                      //   size: 25,
                      //   color: const Color(0xff969696),
                      // ),
                      label: Text(
                        'Planos',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                  NavigationRailDestination(
                      icon: Image.asset(
                        'images/descricao.png',
                        color: Colors.white,
                        width: 30,
                      ),
                      // icon: PhosphorIcon(
                      //   PhosphorIcons.regular.scroll,
                      //   size: 25,
                      //   color: const Color(0xff969696),
                      // ),
                      label: Text(
                        'Descrição',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                  NavigationRailDestination(
                      icon: Image.asset(
                        'images/ofertas.png',
                        color: Colors.white,
                        width: 30,
                      ),
                      // icon: PhosphorIcon(
                      //   PhosphorIcons.regular.tag,
                      //   size: 25,
                      //   color: const Color(0xff969696),
                      // ),
                      label: Text(
                        'Ofertas',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                  NavigationRailDestination(
                    // icon: Image.asset('images/ofertas.png', color: Colors.white, width: 30,),
                    icon: PhosphorIcon(
                      PhosphorIcons.regular.televisionSimple,
                      color: Colors.white,
                      size: 36,
                    ),
                    label: Text(
                      'TV',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Image.asset(
                      'images/perguntas.png',
                      color: Colors.white,
                      width: 30,
                    ),
                    // icon: PhosphorIcon(
                    //   PhosphorIcons.regular.chatCircleDots,
                    //   color: const Color(0xff969696),
                    //   size: 25,
                    // ),
                    label: Text(
                      'Perguntas',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Image.asset(
                      'images/rodape.png',
                      color: Colors.white,
                      width: 30,
                    ),
                    // icon: PhosphorIcon(
                    //   PhosphorIcons.regular.stackSimple,
                    //   color: const Color(0xff969696),
                    //   size: 25,
                    // ),
                    label: Text(
                      'Rodapé',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: PhosphorIcon(PhosphorIcons.regular.signOut,
                        size: 25, color: Colors.red),
                    label: InkWell(
                      onTap: () {
                        html.window.localStorage.remove('authToken');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Login(),
                        ));
                      },
                      child: Text(
                        'Sair',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  Slide(),
                  Plans(),
                  Description(),
                  Ofertas(),
                  TV(),
                  Perguntas(),
                  Footer(),
                  Exit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
