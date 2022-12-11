import 'package:flutter/foundation.dart';
import 'package:something/database.dart';
import 'package:something/models/barang.dart';

class StokProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;

  List<Barang> cart = [];

  StokProvider() {
    _dbHelper = DatabaseHelper();
    listBarang();
  }

  void listBarang() async {
    cart = await _dbHelper.listBarang();
    notifyListeners();
  }

  Future<void> tambahBarang(Barang barang) async {
    await _dbHelper.tambahBarang(barang);
    listBarang();
  }

  Future<void> hapusBarang(int id) async {
    await _dbHelper.hapusBarang(id);
    listBarang();
  }

  Future<void> updateBarang(Barang barang) async {
    await _dbHelper.updateBarang(barang);
    listBarang();
  }
}
