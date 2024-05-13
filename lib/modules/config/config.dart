import 'package:flutter/material.dart';
import 'package:painel_velocitynet/modules/config/component/category.dart';
import 'package:painel_velocitynet/modules/config/component/simulator.dart';
import 'package:painel_velocitynet/modules/entity/menu_entity.dart';

class PlansConfig extends StatefulWidget {
  static const route = 'Configurações';
  final MenuEntity menu;

  const PlansConfig({super.key, required this.menu});

  @override
  State<PlansConfig> createState() => _PlansConfigState();
}

class _PlansConfigState extends State<PlansConfig>
    with SingleTickerProviderStateMixin {
  late TabController _tabControllerr;

  final List<String> tabNames = ['Inicio', 'Sobre', 'Contact'];
  final int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabControllerr = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
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
                    children: const <Widget>[
                      SimulatorComponent(),
                      CategoryComponent()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
