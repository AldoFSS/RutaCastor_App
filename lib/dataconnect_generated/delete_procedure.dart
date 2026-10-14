part of 'generated.dart';

class DeleteProcedureVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteProcedureVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteProcedureData> dataDeserializer = (dynamic json)  => DeleteProcedureData.fromJson(jsonDecode(json));
  Serializer<DeleteProcedureVariables> varsSerializer = (DeleteProcedureVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteProcedureData, DeleteProcedureVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteProcedureData, DeleteProcedureVariables> ref() {
    DeleteProcedureVariables vars= DeleteProcedureVariables(id: id,);
    return _dataConnect.mutation("DeleteProcedure", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteProcedureProcedureDelete {
  final String id;
  DeleteProcedureProcedureDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProcedureProcedureDelete otherTyped = other as DeleteProcedureProcedureDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteProcedureProcedureDelete({
    required this.id,
  });
}

@immutable
class DeleteProcedureData {
  final DeleteProcedureProcedureDelete? procedure_delete;
  DeleteProcedureData.fromJson(dynamic json):
  
  procedure_delete = json['procedure_delete'] == null ? null : DeleteProcedureProcedureDelete.fromJson(json['procedure_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProcedureData otherTyped = other as DeleteProcedureData;
    return procedure_delete == otherTyped.procedure_delete;
    
  }
  @override
  int get hashCode => procedure_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (procedure_delete != null) {
      json['procedure_delete'] = procedure_delete!.toJson();
    }
    return json;
  }

  const DeleteProcedureData({
    this.procedure_delete,
  });
}

@immutable
class DeleteProcedureVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteProcedureVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteProcedureVariables otherTyped = other as DeleteProcedureVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteProcedureVariables({
    required this.id,
  });
}

