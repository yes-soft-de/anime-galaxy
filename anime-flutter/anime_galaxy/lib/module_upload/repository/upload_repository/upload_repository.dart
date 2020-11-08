import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:anime_galaxy/consts/keys.dart';
import 'package:anime_galaxy/consts/urls.dart';
import 'package:anime_galaxy/module_upload/response/imgbb/imgbb_response.dart';
import 'package:anime_galaxy/utils/logger/logger.dart';

@provide
class UploadRepository {
  Future<ImgBBResponse> upload(String filePath) async {
    var client = Dio();
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);

//    Response response = await client.post(
//      Urls.IMGBB,
//      data: data,
//      queryParameters: {'key': ApiKeys.KEY_IMG_DB},
//    );
//    Logger().info('Got a Response', response.toString());
//
//    if (response == null) {
//      return null;
//    }
//    return ImgBBResponse.fromJson(response.data);
  }
}
