// ignore: constant_identifier_names
import 'package:sorteiadate/model/enum/horario_enum.dart';

enum Atividade {
  CAFE_MANHA("Café da manhã", Horario.MANHA),
  CAFE_TARDE("Café da tarde", Horario.TARDE);

  const Atividade(this.nome, this.horario);

  final String nome;
  final Horario horario;
}


