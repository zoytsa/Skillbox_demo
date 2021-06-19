import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PersonDetails {
  String name = "";
  int id = 0;
  String avatar = "";
  String locationName = "";
  String locationUrl = "";
  String status = "";
  String created = "";
  String type = "";
  String gender = "";

  String originName = "";
  String originUrl = "";
  List<dynamic> episodes = [];
}

Future<PersonDetails> loadPerson(int id) async {
  var response = await http
      .get(Uri.parse("https://rickandmortyapi.com/api/character/$id"));
  PersonDetails personDetails;

  var item = convert.jsonDecode(response.body);
  personDetails = PersonDetails();
  personDetails.id = item["id"];
  personDetails.name = item["name"];
  personDetails.avatar = item["image"];
  personDetails.locationName = item["location"]["name"];
  personDetails.locationUrl = item["location"]["url"];
  personDetails.status = item["status"];
  personDetails.created = item["created"];
  personDetails.gender = item["gender"];
  personDetails.type = item["type"];
  personDetails.originName = item["origin"]["name"];
  personDetails.originUrl = item["origin"]["url"];
  personDetails.episodes = item["episode"];

  return personDetails;
}

class LocationDetails {
  int id = 0;
  String name = "";
  String type = "";
  String dimension = "";
  String url = "";
  String created = "";
  List<dynamic> residents = [];
}

Future<LocationDetails> loadLocation(String url) async {
  LocationDetails locationDetails;

  if (url == 'unknown' || url == '') {
    locationDetails = LocationDetails();
    locationDetails.id = 0;
    locationDetails.name = 'unknown';
    locationDetails.type = 'unknown';
    locationDetails.dimension = 'unknown';
    locationDetails.url = 'unknown';
    locationDetails.created = 'unknown';
    locationDetails.residents = [];
  } else {
    var response = await http.get(Uri.parse(url));

    var item = convert.jsonDecode(response.body);
    locationDetails = LocationDetails();
    locationDetails.id = item["id"];
    locationDetails.name = item["name"];
    locationDetails.type = item["type"];
    locationDetails.dimension = item["dimension"];
    locationDetails.url = url;
    locationDetails.created = item["created"];
    locationDetails.residents = item["residents"];
  }
  return locationDetails;
}
