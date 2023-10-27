import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/pages/ofertas.dart';
import 'package:painel_velocitynet/pages/descricao.dart';
import 'package:painel_velocitynet/modules/plans/widget/plans.dart';
import 'package:painel_velocitynet/pages/slide.dart';
import 'package:painel_velocitynet/pages/tv.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        title: Text(
          "Painel - Velocitynet",
          style: GoogleFonts.getFont('Poppins',
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xff212121),
      ),
      body: Row(
        children: [
          // Barra de navegação lateral
          NavigationRail(
            backgroundColor: const Color(0xff212121),
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
                  icon: PhosphorIcon(
                    PhosphorIcons.regular.slideshow,
                    size: 25,
                    color: const Color(0xff969696),
                  ),
                  label: Text(
                    'Slide',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              NavigationRailDestination(
                  icon: PhosphorIcon(
                    PhosphorIcons.regular.globe,
                    size: 25,
                    color: const Color(0xff969696),
                  ),
                  label: Text(
                    'Planos',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              NavigationRailDestination(
                  icon: PhosphorIcon(
                    PhosphorIcons.regular.scroll,
                    size: 25,
                    color: const Color(0xff969696),
                  ),
                  label: Text(
                    'Descrição',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              NavigationRailDestination(
                  icon: PhosphorIcon(
                    PhosphorIcons.regular.tag,
                    size: 25,
                    color: const Color(0xff969696),
                  ),
                  label: Text(
                    'Ofertas',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              NavigationRailDestination(
                icon: PhosphorIcon(
                  PhosphorIcons.regular.televisionSimple,
                  color: const Color(0xff969696),
                  size: 25,
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
                icon: PhosphorIcon(
                  PhosphorIcons.regular.chatCircleDots,
                  color: const Color(0xff969696),
                  size: 25,
                ),
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
                icon: PhosphorIcon(
                  PhosphorIcons.regular.stackSimple,
                  color: const Color(0xff969696),
                  size: 25,
                ),
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
                icon: PhosphorIcon(
                  PhosphorIcons.regular.signOut,
                  size: 25,
                  color: const Color(0xff969696),
                ),
                label: Text(
                  'Sair',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
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
                Planos(),
                Ofertas(),
                TV(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
