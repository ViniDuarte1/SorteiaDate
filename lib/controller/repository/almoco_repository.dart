import 'package:sorteiadate/model/almoco.dart';

abstract class AlmocoRepository {
  Future<int> insertAlmoco(Almoco almoco);
  Future<List<Almoco>> getAllAlmoco();
  Future<List<Almoco>> getAllAlmocoPorClima(int climaId);
  Future<Almoco> sortearAlmocoPorClima(int climaId);
  Future<int> updateAlmoco(Almoco almoco);
  Future<int> deleteAlmoco(int id);
}
