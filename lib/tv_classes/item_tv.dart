class ItemTv {
  final String id;
  final String titulo;
  final String decricao;
  final String valor;

  ItemTv({
    required this.id,
    required this.titulo,
    required this.decricao,
    required this.valor,
  });

  factory ItemTv.fromJson(Map<String, dynamic> json) {
    return ItemTv(
      id: json['_id'],
      titulo: json['title'],
      decricao: json['description'],
      valor: json['value'],
    );
  }
}
