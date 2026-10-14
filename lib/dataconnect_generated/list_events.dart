part of 'generated.dart';

class ListEventsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListEventsVariablesBuilder(this._dataConnect, );
  Deserializer<ListEventsData> dataDeserializer = (dynamic json)  => ListEventsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListEventsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListEventsData, void> ref() {
    
    return _dataConnect.query("ListEvents", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListEventsEvents {
  final String title;
  final Timestamp date;
  ListEventsEvents.fromJson(dynamic json):
  
  title = nativeFromJson<String>(json['title']),
  date = Timestamp.fromJson(json['date']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListEventsEvents otherTyped = other as ListEventsEvents;
    return title == otherTyped.title && 
    date == otherTyped.date;
    
  }
  @override
  int get hashCode => Object.hashAll([title.hashCode, date.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = nativeToJson<String>(title);
    json['date'] = date.toJson();
    return json;
  }

  const ListEventsEvents({
    required this.title,
    required this.date,
  });
}

@immutable
class ListEventsData {
  final List<ListEventsEvents> events;
  ListEventsData.fromJson(dynamic json):
  
  events = (json['events'] as List<dynamic>)
        .map((e) => ListEventsEvents.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListEventsData otherTyped = other as ListEventsData;
    return events == otherTyped.events;
    
  }
  @override
  int get hashCode => events.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['events'] = events.map((e) => e.toJson()).toList();
    return json;
  }

  const ListEventsData({
    required this.events,
  });
}

