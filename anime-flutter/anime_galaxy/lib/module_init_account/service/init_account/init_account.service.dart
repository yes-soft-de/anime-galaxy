import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_init_account/manager/init_account/init_account.manager.dart';
import 'package:anime_galaxy/module_init_account/model/init_account_model.dart';
import 'package:anime_galaxy/module_init_account/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_init_account/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_init_account/response/series_response/series_response.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountService {
  final InitAccountManager _initAccountManager;
  final AuthService _authService;

  InitAccountService(
    this._initAccountManager,
    this._authService,
  );

  Future<List<InitAccountModel>> getCategories() async {
    List<CategoryResponse> response = await _initAccountManager.getCategories();
    if (response == null) return null;

    List<InitAccountModel> data = [];

    response.forEach((element) {
      data.add(new InitAccountModel(
          id: element.id,
          name: element.name,
          image: element.image,
          coverImage: element.coverImage,
          titleShow: element.titleShow ?? true,
          description: element.description,
          series: getSeries(element.series, element.name)));
    });

    return data;
  }

  List<Series> getSeries(
      List<SeriesResponse> seriesResponses, String classification) {
    List<Series> result = [];
    seriesResponses.forEach((element) {
      result.add(new Series(
          id: element.id,
          classification: classification,
          image: element.mainImage,
          name: element.name));
    });

    return result;
  }

  Future<bool> addAnimesToWatch(
      List<FavouriteRequest> favouriteRequests) async {
    var userId = await _authService.userID;
    for (int i = 0; i < favouriteRequests.length; i++) {
      favouriteRequests[i].userID = userId;
    }
    return await _initAccountManager.addAnimesToWatch(favouriteRequests);
  }
}
