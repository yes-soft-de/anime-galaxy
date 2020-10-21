
import 'package:anime_galaxy/generated/l10n.dart';
import 'package:anime_galaxy/module_init_account/model/init_account_model.dart';
import 'package:anime_galaxy/module_init_account/ui/widget/anime_category_Card/anime_category_card.dart';
import 'package:anime_galaxy/module_init_account/ui/widget/series_card/series_card.dart';
import 'package:anime_galaxy/utils/app_bar/anime_galaxy_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:inject/inject.dart';



@provide
class InitAccountScreen extends StatefulWidget {
  @override
  _InitAccountScreenState createState() => _InitAccountScreenState();
}

class _InitAccountScreenState extends State<InitAccountScreen> with TickerProviderStateMixin<InitAccountScreen> {

  List<InitAccountModel> categories=[
    new InitAccountModel(
      name: 'شاونين',
      description: 'هذا النوع من المسلسلات هو نوع مشوق ومليء بالإثارة والمغامرة والحيوية',
      image: 'https://i.pinimg.com/236x/90/10/bb/9010bb9745f2ae4a93bd506345c0ca07--animation-background-environment-concept.jpg',
      series: [
        new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
      ]
    ),
    new InitAccountModel(
        name: 'شاونين',
        description: 'هذا النوع من المسلسلات هو نوع مشوق ومليء بالإثارة والمغامرة والحيوية',
        image: 'https://i.pinimg.com/236x/90/10/bb/9010bb9745f2ae4a93bd506345c0ca07--animation-background-environment-concept.jpg',
        series: [
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        ]
    ),
    new InitAccountModel(
        name: 'شاونين',
        description: 'هذا النوع من المسلسلات هو نوع مشوق ومليء بالإثارة والمغامرة والحيوية',
        image: 'https://i.pinimg.com/236x/90/10/bb/9010bb9745f2ae4a93bd506345c0ca07--animation-background-environment-concept.jpg',
        series: [
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        ]
    ),
    new InitAccountModel(
        name: 'شاونين',
        description: 'هذا النوع من المسلسلات هو نوع مشوق ومليء بالإثارة والمغامرة والحيوية',
        image: 'https://i.pinimg.com/236x/90/10/bb/9010bb9745f2ae4a93bd506345c0ca07--animation-background-environment-concept.jpg',
        series: [
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        ]
    ),
    new InitAccountModel(
        name: 'شاونين',
        description: 'هذا النوع من المسلسلات هو نوع مشوق ومليء بالإثارة والمغامرة والحيوية',
        image: 'https://i.pinimg.com/236x/90/10/bb/9010bb9745f2ae4a93bd506345c0ca07--animation-background-environment-concept.jpg',
        series: [
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
          new Series(name: 'دكتور ستون',image: 'https://i.pinimg.com/236x/5b/27/06/5b2706b1d6459ca81b4576a122844fdc.jpg',classification: 'أكشن شاونين'),
        ]
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return pageLayout();
  }

  Widget pageLayout(){
    return Scaffold(
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
                       return GestureDetector(
                         onTap: (){
                           categories[index].seriesHidden = !categories[index].seriesHidden;
                           setState(() {

                           });
                           print(categories[index].seriesHidden.toString());
                         },
                         child:Column(
                           children: [
                             AnimeCategoryCard(
                               name: categories[index].name,
                               image: categories[index].image,
                               description: categories[index].description,
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
                         )
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
