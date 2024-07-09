// atividade_manha_model.dart
class AtividadeManha {
  int? id;
  String descricao;
  int climaId;

  AtividadeManha({
    this.id,
    required this.descricao,
    required this.climaId,
  });

  factory AtividadeManha.fromMap(Map<String, dynamic> map) {
    return AtividadeManha(
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
