import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lunch_lista/models/Results.dart';
import 'package:lunch_lista/ui/CustomDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDetails extends StatelessWidget {
  final Restaurant restaurant;

  ListDetails({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final headerText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),
        Container(
          width: 100.0,
          child: new Divider(color: Colors.white24),
        ),
        Text(restaurant.name,
            style: TextStyle(color: Colors.white12, fontSize: 45.0))
      ],
    );

    final header = Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(left: 10.0),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("jay-wennington-2065-unsplash.jpg"),
            fit: BoxFit.cover,
          ))),
      Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
        child: Center(
          child: headerText,
        ),
      ),
      Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ))
    ]);

    final headerMenu = Container(
        decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.phone, color: Colors.white54),
              onPressed: () {
                final AndroidIntent phoneIntent = AndroidIntent(
                    action: 'action_view',
                    data: Uri.encodeFull('tel: ${restaurant.phone}'));
                phoneIntent.launch();
              },
            ),
            IconButton(
              icon: Icon(Icons.map, color: Colors.white54),
              onPressed: () {
                final AndroidIntent mapIntent = AndroidIntent(
                    action: 'action_view',
                    data: Uri.encodeFull('geo:0,0?q=${restaurant.address}'),
                    package: 'com.google.android.apps.maps');
                mapIntent.launch();
              },
            ),
            IconButton(
              icon: Icon(Icons.public, color: Colors.white54),
              onPressed: () {
                _launchURL() async {
                  var url = Uri.encodeFull(restaurant.website);
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }

                _launchURL();
              },
            ),
            IconButton(
              icon: Icon(Icons.info, color: Colors.white54),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CustomDialog(
                        title: "Info",
                        description: restaurant.info,
                        buttonText: "Stäng",
                      ),
                );
              },
            )
          ],
        ));

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[header, headerMenu, Content(restaurant: restaurant)],
      ),
    );
  }
}

class Content extends StatelessWidget {
  final Restaurant restaurant;
  Content({Key key, @required this.restaurant}) : super(key: key);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            HtmlWidget(restaurant.menu, webView: true, textStyle: TextStyle(fontSize: 14.0)),
          ],
        ));
  }
}
