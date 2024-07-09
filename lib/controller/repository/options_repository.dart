import 'package:sorteiadate/model/options.dart';

abstract class OptionsRepository {
  Future<int> insertOption(Options option);
  Future<List<Options>> getAllOptions();
  Future<int> updateOption(Options option);
  Future<int> deleteOption(int id);
}
