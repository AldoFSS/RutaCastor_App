part of 'generated.dart';

class CreateProcedureVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateProcedureVariablesBuilder(this._dataConnect, );
  Deserializer<CreateProcedureData> dataDeserializer = (dynamic json)  => CreateProcedureData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateProcedureData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateProcedureData, void> ref() {
    
    return _dataConnect.mutation("CreateProcedure", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class CreateProcedureProcedureInsert {
  final String id;
  CreateProcedureProcedureInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProcedureProcedureInsert otherTyped = other as CreateProcedureProcedureInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const CreateProcedureProcedureInsert({
    required this.id,
  });
}

@immutable
class CreateProcedureData {
  final CreateProcedureProcedureInsert procedure_insert;
  CreateProcedureData.fromJson(dynamic json):
  
  procedure_insert = CreateProcedureProcedureInsert.fromJson(json['procedure_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateProcedureData otherTyped = other as CreateProcedureData;
    return procedure_insert == otherTyped.procedure_insert;
    
  }
  @override
  int get hashCode => procedure_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['procedure_insert'] = procedure_insert.toJson();
    return json;
  }

  const CreateProcedureData({
    required this.procedure_insert,
  });
}

