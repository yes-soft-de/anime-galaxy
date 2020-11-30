import 'package:anime_galaxy/module_explore/style/style_explore_list.dart';
import 'package:flutter/material.dart';

class SeriesCard extends StatelessWidget {
  final String url_image;
  final String series_name;
  final String series_category;

  SeriesCard({this.url_image, this.series_name, this.series_category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      height: 136,
      child: Column(
        children: [
          Container(
            height: 136,
            child: Card(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                image: url_image,
                placeholder: 'assets/images/logo.jpg',
                width: 100,
              ),
              elevation: 0,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${series_name}',
                  style: StyleExploreList.getTextSyle(
                      size: 14, fontWeight: FontWeight.w400, day: true),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${series_category}',
                  style: StyleExploreList.getTextSyle(size: 14, day: true),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
