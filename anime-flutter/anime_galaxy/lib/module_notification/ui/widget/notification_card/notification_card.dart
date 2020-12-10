

import 'package:anime_galaxy/module_notification/ui/widget/circular_image/circular_image.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {

  final String content;
  final String image;
  final String date;

  NotificationCard({
    this.content,
    this.image,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return  Card(

      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,

      ),

      clipBehavior: Clip.hardEdge,
      elevation: 0,
//      color: Color(0xffe4e5eb),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

                    Row(

              children: [
                        CircularImage(w: 50,h:50,linkImg: image??''),



                        SizedBox(width: 10,),

                       Container(
                         width: MediaQuery.of(context).size.width*0.65,
                          child: Text(
                            'ستصدر قريبا حلقة جديدة من المسلسل $content',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
              ],
            ),
//                    Text(
//                        date,
//                      style: TextStyle(
//                      fontSize: 7
//                   ),
//                    ),

          ],
        ),
      ),


    );
  }
}
