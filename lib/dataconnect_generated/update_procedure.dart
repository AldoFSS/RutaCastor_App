part of 'generated.dart';

class UpdateProcedureVariablesBuilder {
  String id;
  String desc;

  final FirebaseDataConnect _dataConnect;
  UpdateProcedureVariablesBuilder(this._dataConnect, {required  this.id,required  this.desc,});
  Deserializer<UpdateProcedureData> dataDeserializer = (dynamic json)  => UpdateProcedureData.fromJson(jsonDecode(json));
  Serializer<UpdateProcedureVariables> varsSerializer = (UpdateProcedureVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateProcedureData, UpdateProcedureVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateProcedureData, UpdateProcedureVariables> ref() {
    UpdateProcedureVariables vars= UpdateProcedureVariables(id: id,desc: desc,);
    return _dataConnect.mutation("UpdateProcedure", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateProcedureProcedureUpdate {
  final String id;
  UpdateProcedureProcedureUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProcedureProcedureUpdate otherTyped = other as UpdateProcedureProcedureUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const UpdateProcedureProcedureUpdate({
    required this.id,
  });
}

@immutable
class UpdateProcedureData {
  final UpdateProcedureProcedureUpdate? procedure_update;
  UpdateProcedureData.fromJson(dynamic json):
  
  procedure_update = json['procedure_update'] == null ? null : UpdateProcedureProcedureUpdate.fromJson(json['procedure_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProcedureData otherTyped = other as UpdateProcedureData;
    return procedure_update == otherTyped.procedure_update;
    
  }
  @override
  int get hashCode => procedure_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (procedure_update != null) {
      json['procedure_update'] = procedure_update!.toJson();
    }
    return json;
  }

  const UpdateProcedureData({
    this.procedure_update,
  });
}

@immutable
class UpdateProcedureVariables {
  final String id;
  final String desc;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateProcedureVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  desc = nativeFromJson<String>(json['desc']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateProcedureVariables otherTyped = other as UpdateProcedureVariables;
    return id == otherTyped.id && 
    desc == otherTyped.desc;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, desc.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['desc'] = nativeToJson<String>(desc);
    return json;
  }

  const UpdateProcedureVariables({
    required this.id,
    required this.desc,
  });
}

