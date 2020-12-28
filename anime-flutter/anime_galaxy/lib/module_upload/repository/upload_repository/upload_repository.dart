import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_upload/response/imgbb/imgbb_response.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';

@provide
class UploadRepository {
  Future<String> upload(String filePath) async {
    var client = Dio();
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });

    Logger().info('image', 'Uploading: ' + filePath);

    Response response =
        await client.post(Urls.API_UPLOAD_USER_IMAGE, data: data);
    Logger().info('Got a Response', response.toString());

    if (response == null) {
      return null;
    }

    return response.toString();
  }
}
