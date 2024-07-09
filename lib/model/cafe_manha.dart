// cafe_manha_model.dart
class CafeManha {
  int? id;
  String descricao;
  int climaId;

  CafeManha({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory CafeManha.fromMap(Map<String, dynamic> map) {
    return CafeManha(
      id: map['id'],
      descricao: map['descricao'],
      climaId: map['clima_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'clima_id': climaId,
    };
  }
}
