
import 'package:anime_galaxy/module_init_account/repository/init_account/init_account.repository.dart';
import 'package:anime_galaxy/module_init_account/request/favourite_request/favourite_request.dart';
import 'package:anime_galaxy/module_init_account/response/category_respponse/category_response.dart';
import 'package:inject/inject.dart';

@provide
class InitAccountManager{
  final InitAccountRepository _initAccountRepository;
  InitAccountManager(this._initAccountRepository);

  Future<List<CategoryResponse>> getCategories()async{
    return await _initAccountRepository.getCategories();
  }

  Future<bool> addAnimesToWatch(List<FavouriteRequest> favouriteRequests)async{

    return await _initAccountRepository.addAnimesToWatch(favouriteRequests);

  }
}