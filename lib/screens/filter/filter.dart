import 'package:anyscan/constants.dart';
import 'package:flutter/material.dart';
import 'package:anyscan/screens/filter/season.dart';
import 'package:sizer/sizer.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

  @override
  Widget build(BuildContext context) {
      var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      body: Column(
        children: [
          Container(
            height: 7.h,
            width: size.width,
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Text('Seasons',
              style: TextStyle(fontSize: 30.sp,
              fontWeight: FontWeight.w900,),),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Stack( 
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                    color: Colors.white),
                  height: size.height,
                  width: size.width
                ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   InkWell(
                     onTap:(){
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => SeasonPage(
                             season:  'Summer' ,
                           ),
                         ),
                       );
                     },
                     child: Container(
                       padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                       height: 20.h,
                       width: size.width-20,
                         decoration: BoxDecoration(
                           color: Colors.yellow[200],
                           borderRadius: BorderRadius.circular(16),
                           boxShadow: [kDefaultShadow],
                             image: DecorationImage(
                               colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.75), BlendMode.dstATop),
                               image: AssetImage('assets/icons/Summer.jpg'),
                               fit: BoxFit.fill)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                           Spacer(),
                           Text(
                             'Summer',
                             style: TextStyle(
                               fontSize: 20.sp,
                               color: Colors.black,
                               fontWeight: FontWeight.w900),
                           ),
                         ],
                       ),
                     ),
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeasonPage(
                                  season:  'Winter' ,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                            height: 20.h,
                            width: size.width/2 -20,
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [kDefaultShadow],
                                  image: DecorationImage(
                                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.75), BlendMode.dstATop),
                                    image: AssetImage('assets/icons/Winter.jpg'),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                Text(
                                  'Winter',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeasonPage(
                                  season:  'Monsoon' ,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                            height: 20.0.h,
                            width: size.width/2 -20,
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [kDefaultShadow],
                                  image: DecorationImage(
                                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.75), BlendMode.dstATop),
                                    image: AssetImage('assets/icons/Monsoon.jpg'),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                Text(
                                  'Monsoon',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeasonPage(
                              season:  'All Seasons' ,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                        height: 20.h,
                        width: size.width-20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [kDefaultShadow],
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.75), BlendMode.dstATop),
                                image: AssetImage('assets/icons/Allseason.jpg'),
                                fit: BoxFit.fill)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Spacer(),
                            Text(
                              'All Seasons',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ),
                 ],
               ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
