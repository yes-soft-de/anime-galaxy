 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimeCategoryCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  AnimeCategoryCard({
    this.image,
    this.name,
    this.description,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width,
      height: 144,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.black38,
        image: DecorationImage(
            image:NetworkImage(image),
            fit: BoxFit.cover
        ),

      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
            Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                    fontFamily: 'Roboto'
                ),
            ),
          Flex(
            direction: Axis.vertical,
            children: [
              Text(
                description,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                    fontFamily: 'Roboto'
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
