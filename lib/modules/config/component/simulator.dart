import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/modules/config/component/complement.dart';
import 'package:painel_velocitynet/pages/planos_abas/create_plans.dart';

class SimulatorComponent extends StatefulWidget {
  const SimulatorComponent({super.key});

  @override
  State<SimulatorComponent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SimulatorComponent> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: NavigationRail(
              indicatorColor: Colors.transparent,
              backgroundColor: const Color(
                0xff181919,
              ),
              extended: true,
              selectedIndex: _currentIndex,
              groupAlignment: BorderSide.strokeAlignInside,
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
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  icon: Image.asset(
                    'images/plano.png',
                    color: Colors.white,
                    width: 20,
                  ),

                  // PhosphorIcon(
                  //   PhosphorIcons.regular.slideshow,
                  //   size: 25,
                  //   color: const Color(0xff969696),
                  // ),

                  label: Text(
                    'Planos',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                NavigationRailDestination(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                    // icon: PhosphorIcon(
                    //   PhosphorIcons.regular.globe,
                    //   size: 25,
                    //   color: const Color(0xff969696),
                    // ),
                    label: Text(
                      'Adicionais',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    )),
                NavigationRailDestination(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  icon: const Icon(
                    Icons.add_box,
                    size: 20,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Complementos',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                NavigationRailDestination(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  icon: const Icon(
                    size: 20,
                    Icons.category_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Card',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.white,
                      fontSize: 15,
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
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Planos',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  backgroundColor: Colors.green),
                              onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const CreatePlans()),
                              child: const Text(
                                '+ Criar Plano',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(
                                    (0xff212121),
                                  ),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Plano Connect - R\$ 99,99',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          side: const BorderSide(
                                              color: Colors.green),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onPressed: () {},
                                      child: const Text(
                                        'Editar',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Adicionais',
                  style: TextStyle(color: Colors.white),
                ),
                // const Text(
                //   'Complementos',
                //   style: TextStyle(color: Colors.white),
                // ),
                const Complement(),
                const Text(
                  'Card',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // PreviewCard(),
        ],
      ),
    );
  }
}
