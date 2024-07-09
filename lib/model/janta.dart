// janta_model.dart
class Janta {
  int? id;
  String descricao;
  int climaId;

  Janta({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory Janta.fromMap(Map<String, dynamic> map) {
    return Janta(
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
