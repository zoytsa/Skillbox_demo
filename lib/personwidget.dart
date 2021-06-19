import 'package:flutter/material.dart';
import 'package:flutter_first_app/personloader.dart';

class PersonDetailsPage extends StatefulWidget {
  PersonDetailsPage({required this.id}) : super();

  final int id;

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsPage> {
  _State({required this.id}) : super();

  int id;
  PersonDetails? personDetails = null;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var personInfo = await loadPerson(id);
    setState(() {
      personDetails = personInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    String myTitle;
    final personDetails = this.personDetails;
    if (personDetails == null) {
      widget = Center(child: Text("Please, wait..."));
      myTitle = "";
    } else {
      widget = SafeArea(
        child: Column(
          children: [
            GestureDetector(
              child: Image.network(
                personDetails.avatar,
                width: double.infinity,
              ),
              onTap: () => {},
            ),
            genderIcon(context, personDetails.gender),
            Text(
              personDetails.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Status: ' + personDetails.status),
            if (personDetails.type != '') Text('type: ' + personDetails.type),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                ),
                Icon(Icons.timelapse, color: Colors.blueAccent),
                Text('Created: ' + personDetails.created,
                    style: TextStyle(
                        color: Colors.red[300], fontStyle: FontStyle.italic))
              ],
            ),
            personLocation(context, personDetails.locationName,
                personDetails.locationUrl, 'Location'),
            personLocation(context, personDetails.originName,
                personDetails.originUrl, 'Origin'),
            Text(
              'Episodes:',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            personEpisodes(context, personDetails.episodes),
          ],
        ),
      );
      myTitle = personDetails.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Person details: " + myTitle),
      ),
      body: widget,
    );
  }
}

Widget genderIcon(BuildContext context, String gender) {
  Widget icon = Icon(Icons.accessibility);
  if (gender == 'Male')
    icon = Icon(
      Icons.male,
      color: Colors.blueAccent[400],
      size: 24.0,
    );
  else if (gender == 'Female')
    icon = Icon(
      Icons.female,
      color: Colors.pink[400],
      size: 24.0,
    );
  return icon;
}

Widget personLocation(BuildContext context, String locationName,
    String locationUrl, String locationTitle) {
  Widget column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.brown[400],
                size: 24.0,
              ),
              onTap: () => {
                if (locationUrl != 'unknown')
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LocationDetailsPage(url: locationUrl)),
                  ),
              }, // go to locationUrl and details...
            ),
            Text(locationTitle + ': ' + locationName),
          ]),
        )
      ]);

  return column;
}

Widget personEpisodes(BuildContext context, List episodes) {
  Widget widget = Flexible(
      child: ListView(
    children: <Widget>[
      for (var i in episodes)
        Card(
          child: Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Text(
              i.toString(),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 5,
            ),
          ),
        )
    ],
  ));

  return widget;
}

class LocationDetailsPage extends StatefulWidget {
  LocationDetailsPage({required this.url}) : super();

  final String url;

  @override
  _LocationDetailsPageState createState() =>
      _LocationDetailsPageState(url: url);
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  _LocationDetailsPageState({required this.url}) : super();

  String url;
  LocationDetails? locationDetails = null;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var locationInfo = await loadLocation(url);
    setState(() {
      locationDetails = locationInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    String myTitle;
    final locationDetails = this.locationDetails;
    if (locationDetails == null) {
      widget = Center(child: Text("Please, wait for location details ..."));
      myTitle = "";
    } else {
      widget = SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Text(
              locationDetails.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('ID: ' + locationDetails.id.toString()),
            //       Text('Name: ' + locationDetails.name),
            Text('Type: ' + locationDetails.type),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                ),
                Icon(Icons.short_text, color: Colors.black45),
                Text('Type: ' + locationDetails.type,
                    style: TextStyle(color: Colors.orange[500]))
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                ),
                Icon(Icons.linear_scale, color: Colors.purple),
                Text('Dimension: ' + locationDetails.dimension,
                    style: TextStyle(color: Colors.green[500]))
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                ),
                Icon(Icons.timelapse, color: Colors.blueAccent),
                Text('Created: ' + locationDetails.created,
                    style: TextStyle(
                        color: Colors.red[300], fontStyle: FontStyle.italic))
              ],
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Text(
              'Residents:',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            locationResidents(context, locationDetails.residents),
          ],
        ),
      );
      myTitle = locationDetails.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Location details: " + myTitle),
      ),
      body: widget,
    );
  }
}

Widget locationResidents(BuildContext context, List residents) {
  Widget widget = Flexible(
      child: ListView(
    children: <Widget>[
      for (var i in residents)
        Card(
          child: Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Text(
              i.toString(),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 1,
            ),
          ),
        )
    ],
  ));

  return widget;
}
