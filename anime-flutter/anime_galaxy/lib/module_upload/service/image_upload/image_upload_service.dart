import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_upload/manager/upload_manager/upload_manager.dart';

@provide
class ImageUploadService {
  final UploadManager manager;

  ImageUploadService(this.manager);

  Future<String> uploadImage(String filePath) async {
    print('qqq  image upload service runing');
    String response = await manager.upload(filePath);
    if (response == null) {
      return null;
    } else {
      print('qqq image uploaded url: ${response}');
      return response;
    }
  }
}
