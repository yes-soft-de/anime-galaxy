
import 'package:anime_galaxy/module_init_account/manager/init_account/init_account.manager.dart';
import 'package:anime_galaxy/module_init_account/model/init_account_model.dart';
import 'package:anime_galaxy/module_init_account/response/category_respponse/category_response.dart';
import 'package:inject/inject.dart';

List<Series> series = [
new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
];

@provide
class InitAccountService{
  final InitAccountManager _initAccountManager;

  InitAccountService(this._initAccountManager);

  Future<List<InitAccountModel>> getCategories() async{
    List<CategoryResponse> response = await _initAccountManager.getCategories();
    if(response == null) return null;

    List<InitAccountModel> data = [];

    response.forEach((element) {
      data.add(new InitAccountModel(
        name: element.name,
        image: 'https://i.pinimg.com/236x/90/10/bb/9010bb9745f2ae4a93bd506345c0ca07--animation-background-environment-concept.jpg',
        description: element.description,
        series: series
      ));
    });

    return data;
  }
}