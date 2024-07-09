// lanche_tarde_model.dart
class LancheTarde {
  int? id;
  String descricao;
  int climaId;

  LancheTarde({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory LancheTarde.fromMap(Map<String, dynamic> map) {
    return LancheTarde(
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
