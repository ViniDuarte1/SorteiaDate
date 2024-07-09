// almoco_model.dart
class Almoco {
  int? id;
  String descricao;
  int climaId;

  Almoco({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory Almoco.fromMap(Map<String, dynamic> map) {
    return Almoco(
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
