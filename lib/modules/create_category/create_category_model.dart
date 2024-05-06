class CreateCategoryModel {
  final String idCategoryPlan;
  final String nomePlano;
  final String subTitulo;
  final String selectVisualizacao;
  final String imageLogoPlano;

  CreateCategoryModel(
      {required this.idCategoryPlan,
      required this.nomePlano,
      required this.subTitulo,
      required this.selectVisualizacao,
      required this.imageLogoPlano});

  factory CreateCategoryModel.fromJson(Map<String, dynamic> json) {
    return CreateCategoryModel(
      idCategoryPlan: json['_id'],
      nomePlano: json['nome'],
      subTitulo: json['subTitulo'],
      selectVisualizacao: json['visualizacao'],
      imageLogoPlano: json['logo'],
    );
  }
}
