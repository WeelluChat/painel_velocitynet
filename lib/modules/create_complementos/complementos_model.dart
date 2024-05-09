class CreateComplementoModel {
  final String idComplemento;
  final String nomeComplemento;
  final String imageComplemento;

  CreateComplementoModel(
      {required this.idComplemento,
      required this.nomeComplemento,
      required this.imageComplemento});

  factory CreateComplementoModel.fromJson(Map<String, dynamic> json) {
    return CreateComplementoModel(
      idComplemento: json['_id'],
      nomeComplemento: json['nome'],
      imageComplemento: json['image'],
    );
  }
}
