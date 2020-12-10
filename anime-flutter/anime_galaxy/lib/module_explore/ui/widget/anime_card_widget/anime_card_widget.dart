
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
      height: 140,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(15),
        color: Colors.black12,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 110,
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
                       width: MediaQuery.of(context).size.width*0.55,
                       child: Text(
                         '$name',
                         overflow: TextOverflow.clip,
                         style: TextStyle(
                             fontSize: 12,
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
