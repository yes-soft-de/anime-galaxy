import 'package:inject/inject.dart';
import 'package:anime_galaxy/module_upload/repository/upload_repository/upload_repository.dart';
import 'package:anime_galaxy/module_upload/response/imgbb/imgbb_response.dart';

@provide
class UploadManager {
  final UploadRepository _repository;
  UploadManager(this._repository);

  Future<String> upload(String filePath) {
    return _repository.upload(filePath);
  }
}
