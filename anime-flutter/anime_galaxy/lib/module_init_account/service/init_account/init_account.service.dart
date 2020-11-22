import 'package:anime_galaxy/module_auth/service/auth_service/auth_service.dart';
import 'package:anime_galaxy/module_init_account/manager/init_account/init_account.manager.dart';
import 'package:anime_galaxy/module_init_account/model/init_account_model.dart';
import 'package:anime_galaxy/module_init_account/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_init_account/response/category_respponse/category_response.dart';
import 'package:anime_galaxy/module_init_account/response/series_response/series_response.dart';
import 'package:inject/inject.dart';

List<Series> series = [
  new Series(
      id: 1,
      name: 'دكتور ستون',
      image:
          'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
      classification: 'أكشن شاونين'),
  new Series(
      id: 2,
      name: 'دكتور ستون',
      image:
          'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
      classification: 'أكشن شاونين'),
  new Series(
      id: 1,
      name: 'دكتور ستون',
      image:
          'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
      classification: 'أكشن شاونين'),
  new Series(
      id: 2,
      name: 'دكتور ستون',
      image:
          'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
      classification: 'أكشن شاونين'),
  new Series(
      id: 1,
      name: 'دكتور ستون',
      image:
          'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
      classification: 'أكشن شاونين'),
  new Series(
      id: 2,
      name: 'دكتور ستون',
      image:
          'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',
      classification: 'أكشن شاونين'),
];

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
          image:element.image,
           description: element.description,
          series: getSeries(element.series, element.name
          )
      )
      );
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
