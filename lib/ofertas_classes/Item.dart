class Item {
  final String id;
  final String titulo;
  final String decricao;
  final String valor;

  Item({
    required this.id,
    required this.titulo,
    required this.decricao,
    required this.valor,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      titulo: json['title'],
      decricao: json['description'],
      valor: json['value'],
    );
  }
}
