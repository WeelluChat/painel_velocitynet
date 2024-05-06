import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/modules/offer/widget/offer.dart';
import 'package:painel_velocitynet/modules/plans/widget/plans.dart';
import 'package:painel_velocitynet/modules/slider/widget/slide.dart';
import 'package:painel_velocitynet/pages/descricao.dart';
import 'package:painel_velocitynet/pages/planos_abas/create_category_alert_dialog.dart';
import 'package:painel_velocitynet/pages/planos_abas/create_plans.dart';
import 'package:painel_velocitynet/pages/planos_abas/teste.dart';
import 'package:painel_velocitynet/pages/tv.dart';

class PlansConfig extends StatefulWidget {
  const PlansConfig({super.key});

  @override
  State<PlansConfig> createState() => _PlansConfigState();
}

class _PlansConfigState extends State<PlansConfig>
    with SingleTickerProviderStateMixin {
  late TabController _tabControllerr;
  @override
  void initState() {
    super.initState();
    _tabControllerr = TabController(
      length: 5,
      vsync: this,
    );
  }

  final List<String> tabNames = ['Inicio', 'Sobre', 'Contact'];
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Planos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width < 600 ? 20 : 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              const CreateCategoryAlertDialog(),
                        ),
                    child: const Text(
                      '+ Criar Categoria',
                      style: TextStyle(color: Colors.green),
                    )),
              )
            ],
          ),
        ),
        Container(
          color: Colors.black,
          width: 1400,
          child: TabBar(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabControllerr,
            dividerColor: Colors.black,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
            ),
            indicator: const BoxDecoration(
              color: Color(
                0xff181919,
              ),
            ),
            tabs: <Widget>[
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      right: BorderSide(color: Color(0xff2F2F2F), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Simulador',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    // style: GoogleFonts.getFont('Poppins',
                    //     color: isVisibleHoje == true
                    //         ? ColorsDashboard().white
                    //         : ColorsDashboard().grey,
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      right: BorderSide(color: Color(0xff2F2F2F), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Connect',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    // style: GoogleFonts.getFont('Poppins',
                    //     color: isVisibleHoje == true
                    //         ? ColorsDashboard().white
                    //         : ColorsDashboard().grey,
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      right: BorderSide(color: Color(0xff2F2F2F), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    // style: GoogleFonts.getFont('Poppins',
                    //     color: isVisibleMensal == true
                    //         ? ColorsDashboard().white
                    //         : ColorsDashboard().grey,
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      right: BorderSide(color: Color(0xff2F2F2F), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Prime',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    // style: GoogleFonts.getFont('Poppins',
                    //     color: isVisibleAnual == true
                    //         ? ColorsDashboard().white
                    //         : ColorsDashboard().grey,
                    //     fontSize: 15,
                    //     fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      right: BorderSide(color: Color(0xff2F2F2F), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Family',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    //   style: GoogleFonts.getFont('Poppins',
                    //       color: isVisibleTotal == true
                    //           ? ColorsDashboard().white
                    //           : ColorsDashboard().grey,
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w500),
                    // ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 100,
                    right: 100,
                  ),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                      right: BorderSide(color: Color(0xff2F2F2F), width: 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Connect Plus',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1370,
          height: 685,
          decoration: const BoxDecoration(
              color: Color(
                0xff181919,
              ),
              border: Border(
                bottom: BorderSide(color: Color(0xff2F2F2F), width: 1),
                left: BorderSide(color: Color(0xff2F2F2F), width: 1),
                right: BorderSide(color: Color(0xff2F2F2F), width: 1),
              )),
          child: TabBarView(
            controller: _tabControllerr,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 300,
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
                              width: 30,
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
                                fontSize: 18,
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 10),
                              icon: const Icon(
                                Icons.add,
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
                                  fontSize: 18,
                                ),
                              )),
                          NavigationRailDestination(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            icon: const Icon(
                              Icons.add_box,
                              color: Colors.white,
                            ),

                            // PhosphorIcon(
                            //   PhosphorIcons.regular.slideshow,
                            //   size: 25,
                            //   color: const Color(0xff969696),
                            // ),

                            label: Text(
                              'Complementos',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          NavigationRailDestination(
                            padding: const EdgeInsets.only(bottom: 10, top: 10),
                            icon: const Icon(
                              Icons.category_outlined,
                              color: Colors.white,
                            ),
                            // icon: PhosphorIcon(
                            //   PhosphorIcons.regular.globe,
                            //   size: 25,
                            //   color: const Color(0xff969696),
                            // ),
                            label: Text(
                              'Card',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1000,
                      height: 300,
                      padding: const EdgeInsets.all(20),
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        children: [
                          // SlidePlans(),
                          const CreatePlans(),
                          Container(
                            width: 200,
                            height: 200,
                            color: Colors.green,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            color: Colors.yellow,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            color: Colors.cyan,
                          ),
                        ],
                      ),
                    ),

                    // PreviewCard(),
                  ],
                ),
              ),
              const Plans(),
              const Testando(),
              Container(color: Colors.red),
              Container(color: Colors.orange),
              Container(color: Colors.deepOrangeAccent),
            ],
          ),
        ),
      ]),
    );
  }
}
