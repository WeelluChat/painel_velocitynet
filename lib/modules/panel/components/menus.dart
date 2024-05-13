import 'package:flutter/material.dart';
import 'package:painel_velocitynet/modules/injection/injection.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Menus extends StatefulWidget {
  const Menus({Key? key}) : super(key: key);

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  List menus = [];

  // PainelController controller = PainelController();
  // UserModel? userRoles;
  // Map<String, dynamic> getUser = {};

  // _loadUserInfo() async {
  //   getUser = await controller.getToken();
  //   setState(() {
  //     userRoles = (UserModel.fromJson(getUser));
  //   });
  // }

  final Map<String, PhosphorIconData> menuIcons = {
    'Slider': PhosphorIcons.regular.slideshow,
    'Configurações': PhosphorIcons.regular.globe,
    'Descrição': PhosphorIcons.regular.scroll,
    'Ofertas': PhosphorIcons.regular.tag,
    'Tv': PhosphorIcons.regular.televisionSimple,
    'Perguntas': PhosphorIcons.regular.chatCircleDots,
    'Rodapé': PhosphorIcons.regular.stackSimple,
    'Sair': PhosphorIcons.regular.signOut,
  };

  // loginRules(privilege, List<dynamic> menus) {
  //   if (privilege == 'Monitor') {
  //     menus.removeWhere((element) => element.contains('Usuários'));
  //     menus.removeWhere((element) => element.contains('Financeiro'));
  //   }
  // }

  menuDetails() async {
    menus = [
      'Slide',
      'Configurações',
      'Descrição',
      'Ofertas',
      'Tv',
      'Perguntas',
      'Rodapé',
      'Sair',
    ];
  }

  @override
  void initState() {
    super.initState();
    // _loadUserInfo();
    menuDetails();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: menus.length,
      itemBuilder: (BuildContext context, int index) {
        final menu = menus[index];
        return MenuTile(
          title: menus[index],
          icon: menuIcons[menu] ?? PhosphorIcons.regular.slideshow,
        );
      },
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final PhosphorIconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: PhosphorIcon(icon),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () => navigationFactory.panelNavigation.toPanel(title),
    );
  }
}
