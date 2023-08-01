import 'index.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = _storage.ref(destination);
      return ref.putData(data);
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
