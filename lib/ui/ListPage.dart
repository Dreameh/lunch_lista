import 'package:flutter/material.dart';
import 'package:lunch_lista/blocs/restaurant_bloc.dart';
import 'package:lunch_lista/models/Results.dart';
import 'package:intl/intl.dart';
import 'package:lunch_lista/ui/ListDetails.dart';
import 'package:lunch_lista/utils/Weekday.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Widget bodyContent(AsyncSnapshot<dynamic> snapshot) {
    List<Restaurant> restaurants = snapshot.data.cache.restaurants;
    var now = new DateTime.now();

    if(now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
      return Container(
        child:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Ingen lunch idag, kom tillbaks på måndag!\n", style: TextStyle(fontSize: 48, color: Colors.black38), textAlign: TextAlign.center),
              Icon(Icons.wb_sunny, color: Colors.yellow, size: 40.0)
            ],
          )
        )
      );
    } else {
    return Container(
        child:
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: restaurants.length,
          itemBuilder: (BuildContext context, int index) {
            return restaurantCard(restaurants, index, context);
          })
    );
    }
  }

  Widget restaurantImage(String imageurl) {
    return imageurl.isEmpty ?
    Image.asset('placeholder.png', width: 130, height: 150) : 
    Image.network(imageurl, width: 130, height: 150);
  }
  

  Widget restaurantCard(List<Restaurant> restaurants, int index, BuildContext context) {
    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          child: restaurantImage(restaurants[index].image),
        ),
        title: Text(
          restaurants[index].name,
          style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(restaurants[index].address),
        trailing: Icon(Icons.keyboard_arrow_right,
            color: Colors.black26, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ListDetails(restaurant: restaurants[index]),
              ));
            },);

    return makeListTile;
  }

  Widget topBar() {
    var now = new DateTime.now();
    

    return AppBar(
      elevation: 0.5,
      backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
      title: Text(
        "Lunch för " + new DateFormat("dd.MM.yyyy").format(now) + " (${Weekday.currentDay(now.weekday)})",
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllRestaurants();

/*     // Bottom Navigation List
    final bottomNav = Container(
        height: 55.0,
        child: BottomAppBar(
            //color: Color.fromRGBO(58, 66, 86, 1.0),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.black26),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.black26),
              onPressed: () {},
            )
          ],
        ))); */

    return Scaffold(
        //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: topBar(),
        //resizeToAvoidBottomPadding: false,
        //bottomNavigationBar: bottomNav,
        body: StreamBuilder(
            stream: bloc.allRestaurants,
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return bodyContent(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}