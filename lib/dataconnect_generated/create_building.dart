part of 'generated.dart';

class CreateBuildingVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateBuildingVariablesBuilder(this._dataConnect, );
  Deserializer<CreateBuildingData> dataDeserializer = (dynamic json)  => CreateBuildingData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateBuildingData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateBuildingData, void> ref() {
    
    return _dataConnect.mutation("CreateBuilding", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class CreateBuildingBuildingInsert {
  final String id;
  CreateBuildingBuildingInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBuildingBuildingInsert otherTyped = other as CreateBuildingBuildingInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const CreateBuildingBuildingInsert({
    required this.id,
  });
}

@immutable
class CreateBuildingData {
  final CreateBuildingBuildingInsert building_insert;
  CreateBuildingData.fromJson(dynamic json):
  
  building_insert = CreateBuildingBuildingInsert.fromJson(json['building_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateBuildingData otherTyped = other as CreateBuildingData;
    return building_insert == otherTyped.building_insert;
    
  }
  @override
  int get hashCode => building_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['building_insert'] = building_insert.toJson();
    return json;
  }

  const CreateBuildingData({
    required this.building_insert,
  });
}

