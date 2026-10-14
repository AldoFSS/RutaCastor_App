part of 'generated.dart';

class ListBuildingsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListBuildingsVariablesBuilder(this._dataConnect, );
  Deserializer<ListBuildingsData> dataDeserializer = (dynamic json)  => ListBuildingsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListBuildingsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListBuildingsData, void> ref() {
    
    return _dataConnect.query("ListBuildings", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListBuildingsBuildings {
  final String name;
  final String? category;
  ListBuildingsBuildings.fromJson(dynamic json):
  
  name = nativeFromJson<String>(json['name']),
  category = json['category'] == null ? null : nativeFromJson<String>(json['category']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListBuildingsBuildings otherTyped = other as ListBuildingsBuildings;
    return name == otherTyped.name && 
    category == otherTyped.category;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, category.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if (category != null) {
      json['category'] = nativeToJson<String?>(category);
    }
    return json;
  }

  const ListBuildingsBuildings({
    required this.name,
    this.category,
  });
}

@immutable
class ListBuildingsData {
  final List<ListBuildingsBuildings> buildings;
  ListBuildingsData.fromJson(dynamic json):
  
  buildings = (json['buildings'] as List<dynamic>)
        .map((e) => ListBuildingsBuildings.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListBuildingsData otherTyped = other as ListBuildingsData;
    return buildings == otherTyped.buildings;
    
  }
  @override
  int get hashCode => buildings.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['buildings'] = buildings.map((e) => e.toJson()).toList();
    return json;
  }

  const ListBuildingsData({
    required this.buildings,
  });
}

