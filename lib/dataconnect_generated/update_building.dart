part of 'generated.dart';

class UpdateBuildingVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  UpdateBuildingVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateBuildingData> dataDeserializer = (dynamic json)  => UpdateBuildingData.fromJson(jsonDecode(json));
  Serializer<UpdateBuildingVariables> varsSerializer = (UpdateBuildingVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateBuildingData, UpdateBuildingVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateBuildingData, UpdateBuildingVariables> ref() {
    UpdateBuildingVariables vars= UpdateBuildingVariables(id: id,);
    return _dataConnect.mutation("UpdateBuilding", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateBuildingBuildingUpdate {
  final String id;
  UpdateBuildingBuildingUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateBuildingBuildingUpdate otherTyped = other as UpdateBuildingBuildingUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const UpdateBuildingBuildingUpdate({
    required this.id,
  });
}

@immutable
class UpdateBuildingData {
  final UpdateBuildingBuildingUpdate? building_update;
  UpdateBuildingData.fromJson(dynamic json):
  
  building_update = json['building_update'] == null ? null : UpdateBuildingBuildingUpdate.fromJson(json['building_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateBuildingData otherTyped = other as UpdateBuildingData;
    return building_update == otherTyped.building_update;
    
  }
  @override
  int get hashCode => building_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (building_update != null) {
      json['building_update'] = building_update!.toJson();
    }
    return json;
  }

  const UpdateBuildingData({
    this.building_update,
  });
}

@immutable
class UpdateBuildingVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateBuildingVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateBuildingVariables otherTyped = other as UpdateBuildingVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const UpdateBuildingVariables({
    required this.id,
  });
}

