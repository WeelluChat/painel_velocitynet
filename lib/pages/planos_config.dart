import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/modules/offer/widget/offer.dart';
import 'package:painel_velocitynet/modules/plans/widget/plans.dart';
import 'package:painel_velocitynet/modules/slider/widget/slide.dart';
import 'package:painel_velocitynet/pages/complementos/complemento.dart';
import 'package:painel_velocitynet/pages/descricao.dart';
import 'package:painel_velocitynet/pages/planos_abas/create_category_alert_dialog.dart';
import 'package:painel_velocitynet/pages/planos_abas/create_plans.dart';
import 'package:painel_velocitynet/pages/planos_abas/teste.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PlansConfig extends StatefulWidget {
  const PlansConfig({super.key});

  @override
  State<PlansConfig> createState() => _PlansConfigState();
}

class _PlansConfigState extends State<PlansConfig>
    with SingleTickerProviderStateMixin {
  late TabController _tabControllerr;

  final List<String> tabNames = ['Inicio', 'Sobre', 'Contact'];
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<String> getTokenFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token ?? '';
  }

  List<dynamic> categoryPlans = [];
  Future<void> CategoryPlans() async {
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
      setState(() {
        categoryPlans = json.decode(response.body);
      });
    } else {
      print('Erro ao buscar dados: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabControllerr = TabController(
      length: 5,
      vsync: this,
    );
    CategoryPlans();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Configurações',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width < 600 ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          TabBar(
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
                    'Categorias',
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
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
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
                    Padding(
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
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
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
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
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
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
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
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25, right: 25),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () => showDialog<
                                                      String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          const CreatePlans()),
                                              child: const Text(
                                                '+ Criar Plano',
                                                style: TextStyle(
                                                    color: Colors.white),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: const Color(
                                                    (0xff212121),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.grey[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Plano Connect - R\$ 99,99',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Poppins',
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          side:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .green),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5))),
                                                      onPressed: () {},
                                                      child: const Text(
                                                        'Editar',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
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
                                const Complementos(),
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
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Categorias',
                                  style: GoogleFonts.getFont('Poppins',
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        backgroundColor: Colors.green),
                                    onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              const CreateCategoryAlertDialog(),
                                        ),
                                    child: const Text(
                                      '+ Criar Categoria',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: categoryPlans.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 20,
                                        top: 5,
                                        bottom: 5),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 35,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  categoryPlans[index]['nome'],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                side: const BorderSide(
                                                    color: Colors.green),
                                                backgroundColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                'Editar',
                                                style: TextStyle(
                                                    color: Colors.green),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
