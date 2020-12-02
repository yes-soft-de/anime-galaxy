import 'package:anime_galaxy/generated/l10n.dart';
import 'package:flutter/material.dart';

class AnimeCardWidget extends StatelessWidget {
  final String name;
  final String category;
  final String image;

  AnimeCardWidget({
    this.name,
    this.image,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(15),
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(image ??
                    'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width*0.5,
                       child: Text(
                         '$name',
                         style: TextStyle(
                             fontSize: 14,
                             fontFamily:'Roboto',
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ),
                   ],
                 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$category',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily:'Roboto',
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
