part of 'generated.dart';

class DeleteBuildingVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteBuildingVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteBuildingData> dataDeserializer = (dynamic json)  => DeleteBuildingData.fromJson(jsonDecode(json));
  Serializer<DeleteBuildingVariables> varsSerializer = (DeleteBuildingVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteBuildingData, DeleteBuildingVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteBuildingData, DeleteBuildingVariables> ref() {
    DeleteBuildingVariables vars= DeleteBuildingVariables(id: id,);
    return _dataConnect.mutation("DeleteBuilding", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteBuildingBuildingDelete {
  final String id;
  DeleteBuildingBuildingDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteBuildingBuildingDelete otherTyped = other as DeleteBuildingBuildingDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteBuildingBuildingDelete({
    required this.id,
  });
}

@immutable
class DeleteBuildingData {
  final DeleteBuildingBuildingDelete? building_delete;
  DeleteBuildingData.fromJson(dynamic json):
  
  building_delete = json['building_delete'] == null ? null : DeleteBuildingBuildingDelete.fromJson(json['building_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteBuildingData otherTyped = other as DeleteBuildingData;
    return building_delete == otherTyped.building_delete;
    
  }
  @override
  int get hashCode => building_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (building_delete != null) {
      json['building_delete'] = building_delete!.toJson();
    }
    return json;
  }

  const DeleteBuildingData({
    this.building_delete,
  });
}

@immutable
class DeleteBuildingVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteBuildingVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteBuildingVariables otherTyped = other as DeleteBuildingVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteBuildingVariables({
    required this.id,
  });
}

