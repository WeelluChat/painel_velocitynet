import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:painel_velocitynet/constantes/api_url.dart';
import 'package:painel_velocitynet/modules/config/config_provider/config_provider.dart';
import 'package:painel_velocitynet/pages/planos_abas/create_category_alert_dialog.dart';
import 'package:provider/provider.dart';

class CategoryComponent extends StatefulWidget {
  const CategoryComponent({super.key});

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  @override
  void initState() {
    super.initState();
    context.read<ConfigProvider>().loadCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          borderRadius: BorderRadius.circular(5)),
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
        Consumer<ConfigProvider>(
          builder: (context, controler, _) {
            return Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controler.category.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 5, bottom: 5),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                controler.category[index].imageLogoPlano == ""
                                    ? Container(
                                        width: 35,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      )
                                    : SizedBox(
                                        width: 35,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50)),
                                          child: Image.network(
                                            fit: BoxFit.cover,
                                            '${ApiContants.baseApi}/uploads/${controler.category[index].imageLogoPlano}',
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  controler.category[index].nomePlano,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: Colors.green),
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Editar',
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
