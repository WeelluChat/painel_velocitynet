import 'package:flutter/material.dart';

class Testando extends StatefulWidget {
  const Testando({super.key});

  @override
  State<Testando> createState() => _TestandoState();
}

class _TestandoState extends State<Testando>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<String> tabNames = [
    'Inicio',
    'Sobre',
    'Contact',
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabNames.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: 1400,
      child: TabBar(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        controller: _tabController,
        dividerColor: Colors.black,
        indicatorColor: Colors.transparent,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        indicator: const BoxDecoration(color: Color(0xff181919)),
        tabs: tabNames
            .map(
              (name) => Tab(
                child: Container(
                  padding: const EdgeInsets.only(left: 100, right: 100),
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
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
