import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_anime/anime_routes.dart';
import 'package:anime_galaxy/module_explore/model/category_animes/category_animes.model.dart';
import 'package:anime_galaxy/module_explore/model/explore/explore_model.dart';
import 'package:anime_galaxy/module_explore/state/category_animes/category_animes.state.dart';
import 'package:anime_galaxy/module_explore/state_manager/category_animes/category_animes.state_manager.dart';
import 'package:anime_galaxy/module_explore/ui/widget/anime_card_widget/anime_card_widget.dart';
import 'package:anime_galaxy/utils/loading_indicator/loading_indicator.dart';
import 'package:anime_galaxy/utils/project_color/project_color.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class CategoryAnimesScreen extends StatefulWidget {
  final CategoryAnimesStateManager _stateManager;

  CategoryAnimesScreen(this._stateManager);

  @override
  _CategoryAnimesScreenState createState() => _CategoryAnimesScreenState();
}

class _CategoryAnimesScreenState extends State<CategoryAnimesScreen> {
  List<CategoryAnimesModel> animes =[];
  bool loading = true;
  CategoryAnimesState currentState = CategoryAnimesStateInit();
  Category category;

  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
   widget._stateManager.stateStream.listen((event) {
     currentState = event;
     if(currentState is CategoryAnimesStateFetchingSuccess){
       CategoryAnimesStateFetchingSuccess state = currentState;
       animes = state.data;
       loading = false;
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
    category = ModalRoute.of(context).settings.arguments;
    if(currentState is CategoryAnimesStateInit){
      widget._stateManager.getCategorySeries(category.id, category.name);
    }
    return loading?
            LoadingIndicatorWidget():
            _screenUi()
    ;
  }

  Widget _screenUi(){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
           child: Column(
             children: [
                 Container(
                   height: 150,
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(3.0)),
                     image: DecorationImage(
                         image: NetworkImage(
                             category.image??'https://i.pinimg.com/236x/ec/e4/b0/ece4b097f87bd6a79d8e05cfd45d17d6--matte-painting-digital-paintings.jpg'
                         ),
                         fit: BoxFit.cover),

                   ),
                   child:  Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         category.titleShow?category.name:'',
                         textAlign: TextAlign.center,
                         style:  TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.white,
                             fontFamily:'Roboto',
                           shadows: [
                             Shadow(
                               color: Colors.black,
                               offset: Offset(0.5,0.5),
                               blurRadius: 1.5
                             )
                           ]
                         ),
                       ),
                     ],
                   )
                 ),
               Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Center(
                   child: TextFormField(
                     controller: _searchController,
                     onFieldSubmitted: (value) {
                       _searchController.text.trim()==''
                           ?widget._stateManager.getCategorySeries(category.id, category.name)
                           :widget._stateManager.search(category.id,_searchController.text.trim());
                     },
                     decoration: InputDecoration(
                       hintText:
                       'بحث' ,
                       suffixIcon: IconButton(
                           icon: Icon(
                             Icons.search,
                             color: ProjectColors.ThemeColor,
                           ),
                           onPressed: () {
                             _searchController.text.trim()==''
                                 ?widget._stateManager.getCategorySeries(category.id, category.name)
                                 :widget._stateManager.search(category.id,_searchController.text.trim());

                           }),
                     ),

                   ),
                 ),
               ),

               if(animes.isNotEmpty)
                 ListView.builder(
                     shrinkWrap: true,
                     padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 10),
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: animes.length,
                     itemBuilder: (BuildContext context, int index){
                       return Container(
                         margin: EdgeInsets.all(10),
                         child: GestureDetector(
                           onTap: ()=> Navigator.pushNamed(
                               context,
                               AnimeRoutes.ROUTE_ANIME_DETAILS_SCREEN ,
                               arguments: animes[index].animeId
                           ),
                           child: AnimeCardWidget(
                             name: animes[index].animeName,
                             image: animes[index].animeImage,
                             category: animes[index].animeCategory,
                             ageGroup: animes[index].ageGroup,
                             comments: animes[index].comments,
                             episodesCount: animes[index].episodesCount,
                             generalRating: animes[index].generalRating,
                             rating: animes[index].rating,
                             likes: animes[index].likes,
                           ),
                         ),
                       );
                     }
                 ),
             ],
           ),
        ),
      ),
    );
  }
}
