import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(int rating);

class  AnimeRatingBar extends StatelessWidget {
  final int itemCount;
  final int rating;
  final RatingChangeCallback onRatingChanged;
  final Icon fillIcon;
  final Icon emptyIcon;
  final Icon halfFillIcon;
  final Color color;
  final double itemSize;

  AnimeRatingBar(
      {
        this.itemCount = 5,
        this.rating = 0,
        this.onRatingChanged,
        this.color,
        this.fillIcon,
        this.emptyIcon,
        this.halfFillIcon,
        this.itemSize=40,
      }
      );

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = emptyIcon;
    }
    else if (index > rating - 1 && index < rating) {
      icon = halfFillIcon;
    } else {
      icon = fillIcon;
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1),
      child: SizedBox(
          width: itemSize ,
          height: itemSize,
          child: FittedBox(
            fit: BoxFit.contain,
              child: RotatedBox(quarterTurns:2,child: icon)
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(itemCount, (index) => buildStar(context, index)));
  }
}


//to use it
//StarRating(
//rating: rating,
//onRatingChanged: (rating) => setState(() => this.rating = rating),
//);