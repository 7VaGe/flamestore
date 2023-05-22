import 'package:flutter/material.dart';
import 'package:test_flamestore/utils/NgrokLink.dart';
import 'package:test_flamestore/widgets/StoreCard/components/StarRating.dart';

class StoreCard extends StatefulWidget {
  final avatarImage;
  final String productName;
  final String price;
  final String imageName;
  final double rating;
  final void Function()? callback;

  const StoreCard(
      {this.avatarImage,
      required this.productName,
      required this.price,
      this.imageName = "t.jpg",
      required this.callback,
      this.rating = 3.5});

  @override
  _StoreCardState createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Container(
              child: Image.network(
                NgrokLink.link + '/theFlameStore/images/' + widget.imageName,
                fit: BoxFit.fill,
              ),
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.productName,
                textScaleFactor: 0.8,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              left: 8,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            StarRating(
              rating: widget.rating,
              color: Colors.blue[300] as Color,
              onRatingChanged: (double rating) {},
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              widget.rating.toString(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                /* fontStyle: FontStyle.italic, */
              ),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            Container(
              child: Text(
                "" + widget.price + "\$",
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
              padding: EdgeInsets.only(
                left: 8,
                bottom: 8,
              ),
              margin: EdgeInsets.only(
                right: 5,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              child: GestureDetector(
                onTap: widget.callback,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: Color.fromRGBO(170, 170, 170, 1),
                        ),
                        Text("Buy Now!",
                            style: TextStyle(
                              color: Color.fromRGBO(170, 170, 170, 1),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              margin: EdgeInsets.only(
                bottom: 10,
              ),
            ),
          ]),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
