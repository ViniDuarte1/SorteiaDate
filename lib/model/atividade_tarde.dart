// atividade_tarde_model.dart
class AtividadeTarde {
  int? id;
  String descricao;
  int climaId;

  AtividadeTarde({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory AtividadeTarde.fromMap(Map<String, dynamic> map) {
    return AtividadeTarde(
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
