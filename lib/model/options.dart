import 'package:sorteiadate/model/enum/clima_enum.dart';
import 'package:sorteiadate/model/enum/horario_enum.dart';


// Classe Options
class Options {
  final int? id;
  final String nome;
  final Horario horario;
  final Clima clima;

  // Construtor
  Options({
    this.id,
    required this.nome,
    required this.horario,
    required this.clima,
  });

  // Método para converter um mapa em uma instância de Options
  factory Options.fromMap(Map<String, dynamic> map) {
    return Options(
      id: map['id'],
      nome: map['nome'],
      horario: Horario.values[map['horario']],
      clima: Clima.values[map['clima']],
    );
  }

  // Método para converter uma instância de Options em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'horario': horario.index,
      'clima': clima.index,
    };
  }
}
