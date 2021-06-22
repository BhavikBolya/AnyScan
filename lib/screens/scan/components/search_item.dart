import 'package:anyscan/constants.dart';
import 'package:anyscan/screens/details/details.dart';
import 'package:anyscan/screens/scan/components/getJson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _typeAheadController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Image.asset('assets/icons/Fruitsbg.png'),
                  )
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios), 
                        onPressed: () { 
                          Navigator.pop(context);
                         },
                      ),
                    ),
                    Container(
                       margin: EdgeInsets.symmetric(vertical: 20),
                       decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TypeAheadField<User?>(
                      hideSuggestionsOnKeyboardHide: false,
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _typeAheadController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,),
                            suffixIcon: IconButton(
                              iconSize: 30,
                              color: Colors.black,
                              icon: Icon(Icons.clear_sharp), 
                              onPressed: () {
                                this._typeAheadController.clear();
                               },
                            ),
                          hintText: 'Search Fruits/Vegetables',
                        ),
                      ),
                      suggestionsCallback: UserData.getItemSuggestions,
                      itemBuilder: (context, User? suggestion) {
                        final user = suggestion!;
                
                        return ListTile(
                          title: Text(user.Name),
                        );
                      },
                      noItemsFoundBuilder: (context) => Container(
                        height: 100,
                        child: Center(
                          child: Text(
                            'No Items Found.',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      onSuggestionSelected: (User? suggestion) {
                        final String item = suggestion!.Name;
                
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(fruit_name: item),
                        ));
                      },
                  ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}