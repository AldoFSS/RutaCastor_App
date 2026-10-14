part of 'generated.dart';

class GetBuildingVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetBuildingVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetBuildingData> dataDeserializer = (dynamic json)  => GetBuildingData.fromJson(jsonDecode(json));
  Serializer<GetBuildingVariables> varsSerializer = (GetBuildingVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetBuildingData, GetBuildingVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetBuildingData, GetBuildingVariables> ref() {
    GetBuildingVariables vars= GetBuildingVariables(id: id,);
    return _dataConnect.query("GetBuilding", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetBuildingBuilding {
  final String name;
  final double latitude;
  final double longitude;
  final String? description;
  GetBuildingBuilding.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  latitude = nativeFromJson<double>(json['latitude']),
  longitude = nativeFromJson<double>(json['longitude']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetBuildingBuilding otherTyped = other as GetBuildingBuilding;
    return name == otherTyped.name && 
    latitude == otherTyped.latitude && 
    longitude == otherTyped.longitude && 
    description == otherTyped.description;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, latitude.hashCode, longitude.hashCode, description.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['latitude'] = nativeToJson<double>(latitude);
    json['longitude'] = nativeToJson<double>(longitude);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    return json;
  }

  const GetBuildingBuilding({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.description,
  });
}

@immutable
class GetBuildingData {
  final GetBuildingBuilding? building;
  GetBuildingData.fromJson(dynamic json):
  
  building = json['building'] == null ? null : GetBuildingBuilding.fromJson(json['building']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetBuildingData otherTyped = other as GetBuildingData;
    return building == otherTyped.building;
    
  }
  @override
  int get hashCode => building.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (building != null) {
      json['building'] = building!.toJson();
    }
    return json;
  }

  const GetBuildingData({
    this.building,
  });
}

@immutable
class GetBuildingVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetBuildingVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetBuildingVariables otherTyped = other as GetBuildingVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const GetBuildingVariables({
    required this.id,
  });
}

