
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_init_account/model/init_account_model.dart';
import 'package:anime_galaxy/module_init_account/state/init_account/init_account.state.dart';
import 'package:anime_galaxy/module_init_account/state_manager/init_account/init_account.state_manager.dart';
import 'package:anime_galaxy/module_init_account/ui/widget/anime_category_Card/anime_category_card.dart';
import 'package:anime_galaxy/module_init_account/ui/widget/series_card/series_card.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';



@provide
class InitAccountScreen extends StatefulWidget {
  final InitAccountStateManager _stateManager;

  InitAccountScreen(this._stateManager);

  @override
  _InitAccountScreenState createState() => _InitAccountScreenState();
}

class _InitAccountScreenState extends State<InitAccountScreen> with TickerProviderStateMixin<InitAccountScreen> {
  InitAccountState currentState = InitAccountStateInit();
  List<InitAccountModel> categories=[];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      processEvent();
    });
  }
  void processEvent(){
    if(currentState is InitAccountStateSuccess){
      InitAccountStateSuccess state = currentState;
      categories = state.data;
      if (this.mounted) {
        setState(() {});
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    if (currentState is InitAccountStateInit) {
      widget._stateManager.getCategories();
      loading = false;
      if(this.mounted){
        setState(() {});
      }
//      if(currentState is InitAccountStateFetching){
//
//        return setLoadingUI();
//
//      }
//      if(currentState is InitAccountStateError){
//        return setErrorUI();
//      }
//
//      if(currentState is InitAccountStateSuccess){
//
//        return pageLayout();
//      }
//
    }
    return pageLayout();
  }

  Widget setLoadingUI() {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            CircularProgressIndicator(),
          ],
        )
      ],
    );
  }

  Widget setErrorUI() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Text(S.of(context).errorLoadingItems),
        OutlineButton(
          onPressed: () {

            widget._stateManager.getCategories();
          },
          child: Text(S.of(context).retry),
        )
      ],
    );
  }


  Widget pageLayout(){
    return loading ? setLoadingUI():
    Scaffold(
      appBar: AnimeGalaxyAppBar.getBackEnabledAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).startWachingSeries,

                      )
                    ],
                  ),
                ),

                 ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: categories.length,
                     shrinkWrap: true,
                     itemBuilder:(BuildContext context,int index){
                       return Column(
                         children: [

                           GestureDetector(
                           onTap: (){
                         categories[index].seriesHidden = !categories[index].seriesHidden;
                         setState(() {

                         });

                       },
                               child: AnimeCategoryCard(
                               name: categories[index].name,
                               image: categories[index].image,
                               description: categories[index].description,
                               ),

                       ),

                           new AnimatedSize(
                               vsync: this,
                               duration: const Duration(milliseconds: 500),
                               child: new ConstrainedBox(
                                 constraints: !categories[index].seriesHidden
                                     ? new BoxConstraints()
                                     : new BoxConstraints(maxHeight: 0.0),
                                 child:  GridView.builder(itemBuilder: (BuildContext context, int index2){

                                   return  SeriesCard(
                                     image: categories[index].series[index2].image,
                                     name: categories[index].series[index2].name,
                                     classification:categories[index].series[index2].classification,
                                   );
                                 },
                                   padding: EdgeInsets.symmetric(horizontal: 10),
                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                       crossAxisCount: 3,
                                       mainAxisSpacing: 20,
                                       crossAxisSpacing: 20,
                                       childAspectRatio: (2.3/4)
                                   ),
                                   itemCount:categories[index].series.length,
                                   physics: NeverScrollableScrollPhysics(),
                                   shrinkWrap: true,),


//
                               )
                           ),
                         ],
                       );

                     })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
