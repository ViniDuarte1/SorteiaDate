// atividade_noite_model.dart
class AtividadeNoite {
  int? id;
  String descricao;
  int climaId;

  AtividadeNoite({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory AtividadeNoite.fromMap(Map<String, dynamic> map) {
    return AtividadeNoite(
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
