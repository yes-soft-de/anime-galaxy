import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_profile/presistance/profile_shared_preferences.dart';
import 'package:anime_galaxy/module_profile/service/general_profile/general_profile.dart';
import 'package:anime_galaxy/module_search/model/search_model/search_model.dart';
import 'package:anime_galaxy/module_search/state/search/search.state.dart';
import 'package:anime_galaxy/module_search/state_manager/search/search.state_manager.dart';
import 'package:anime_galaxy/module_search/ui/widget/anime_card_widget/anime_card_widget.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class SearchScreen extends StatefulWidget {
  final SearchStateManager _stateManager;

  SearchScreen(this._stateManager);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  SearchState currentSate = SearchStateInit();
  List<SearchModel> searchResult = [];
  bool loading = false;

  @override
  void initState() {
    widget._stateManager.stateStream.listen((event) {
      currentSate = event;
      if(currentSate is SearchStateFetchingSuccess){
        loading = false;
        SearchStateFetchingSuccess state = currentSate;
        searchResult = state.data;
        if(this.mounted){
          setState(() {

          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading?
                LoadingIndicatorWidget():
                _pageUi();
  }

  Widget _pageUi(){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            onPressed: ()=>Navigator.pop(context),
            icon: Icon(Icons.arrow_back,color: ProjectColors.ThemeColor, ),
          ),
          title:       TextFormField(
            controller: _searchController,
            onFieldSubmitted: (value){
              setState(() {
                loading = true;
              });
              widget._stateManager.searchAnime(_searchController.text.trim());
              },
            decoration: InputDecoration(
                hintText: S.of(context).searchForAnAnime,
            ),
            validator: (result) {
              if (result.isEmpty) {
                return 'اكتب اسم الانمي الذي تبحث عنه';
              }
              return null;
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: (){

                setState(() {
                  loading = true;
                });
                widget._stateManager.searchAnime(_searchController.text.trim());
              },
              icon: Icon(Icons.search,color: ProjectColors.ThemeColor, ),
            ),

          ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(searchResult.isNotEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: searchResult.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: ()=> Navigator.pushNamed(
                            context,
                          AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN , 
                          arguments: searchResult[index].animeId
                        ),
                        child: AnimeCardWidget(
                          name: searchResult[index].animeName,
                          image: searchResult[index].animeImage,
                          category: searchResult[index].animeCategory,
                          ageGroup: searchResult[index].ageGroup,
                          comments: searchResult[index].comments,
                          episodesCount: searchResult[index].episodesCount,
                          generalRating: searchResult[index].generalRating,
                          rating: searchResult[index].rating,
                          likes: searchResult[index].likes,
                        ),
                      ),
                    );
                  }
              ),
          ],
        ),
      ),
    );
  }
}
