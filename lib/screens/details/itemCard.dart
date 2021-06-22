import 'package:anyscan/screens/details/details.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.image,
    required this.english, 
    required this.hindi, 
    required this.itemIndex, 
  }) : super(key: key);

  final int itemIndex;
  final String image;
  final String english;
  final String hindi;
  
  @override
  Widget build(BuildContext context) {
    press() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          fruit_name:  english ,
        ),
      ),
    );
  }

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '$image',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160,
                  width: 200,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 100,
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                          english+' | '+hindi,
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}