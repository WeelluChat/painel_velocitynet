class PlansModel {
  final String idSimulador;
  final String nome;
  final String descricao;
  final String idCategoria;
  final List<String> complementar;
  final String preco;
  final String imagem;
  final String planoBase;

  PlansModel(
      {required this.idSimulador,
      required this.nome,
      required this.descricao,
      required this.idCategoria,
      required this.complementar,
      required this.preco,
      required this.imagem,
      required this.planoBase});

  factory PlansModel.fromJson(Map<String, dynamic> json) {
    return PlansModel(
        idSimulador: json['_id'],
        nome: json['nome'],
        descricao: json['descricao'],
        idCategoria: json['idCategoria'],
        complementar:
            List<String>.from(json['complementar'].map((comp) => comp['id'])),
        preco: json['preco']['\$numberDecimal'],
        imagem: json['imagem'],
        planoBase: json['planoBase']);
  }
}
