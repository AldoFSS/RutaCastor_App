part of 'generated.dart';

class GetEventVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetEventVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetEventData> dataDeserializer = (dynamic json)  => GetEventData.fromJson(jsonDecode(json));
  Serializer<GetEventVariables> varsSerializer = (GetEventVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetEventData, GetEventVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetEventData, GetEventVariables> ref() {
    GetEventVariables vars= GetEventVariables(id: id,);
    return _dataConnect.query("GetEvent", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetEventEvent {
  final String title;
  final Timestamp date;
  final GetEventEventLocation location;
  GetEventEvent.fromJson(dynamic json):
  
  title = nativeFromJson<String>(json['title']),
  date = Timestamp.fromJson(json['date']),
  location = GetEventEventLocation.fromJson(json['location']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetEventEvent otherTyped = other as GetEventEvent;
    return title == otherTyped.title && 
    date == otherTyped.date && 
    location == otherTyped.location;
    
  }
  @override
  int get hashCode => Object.hashAll([title.hashCode, date.hashCode, location.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = nativeToJson<String>(title);
    json['date'] = date.toJson();
    json['location'] = location.toJson();
    return json;
  }

  const GetEventEvent({
    required this.title,
    required this.date,
    required this.location,
  });
}

@immutable
class GetEventEventLocation {
  final String name;
  GetEventEventLocation.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetEventEventLocation otherTyped = other as GetEventEventLocation;
    return name == otherTyped.name;
    
  }
  @override
  int get hashCode => name.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  const GetEventEventLocation({
    required this.name,
  });
}

@immutable
class GetEventData {
  final GetEventEvent? event;
  GetEventData.fromJson(dynamic json):
  
  event = json['event'] == null ? null : GetEventEvent.fromJson(json['event']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetEventData otherTyped = other as GetEventData;
    return event == otherTyped.event;
    
  }
  @override
  int get hashCode => event.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (event != null) {
      json['event'] = event!.toJson();
    }
    return json;
  }

  const GetEventData({
    this.event,
  });
}

@immutable
class GetEventVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetEventVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetEventVariables otherTyped = other as GetEventVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const GetEventVariables({
    required this.id,
  });
}

