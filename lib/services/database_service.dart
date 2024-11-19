import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWatchedAnimes(List<dynamic> animes, String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'watchedAnimes': animes,
      });
    } catch (e) {
      print('Lỗi khi lưu dữ liệu: $e');
    }
  }

  Future<void> saveReadMangas(List<dynamic> mangas, String userId) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'readMangas': mangas,
      });
    } catch (e) {
      print('Lỗi khi lưu dữ liệu: $e');
    }
  }
}
