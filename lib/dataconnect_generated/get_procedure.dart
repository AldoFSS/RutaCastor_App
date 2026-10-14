part of 'generated.dart';

class GetProcedureVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetProcedureVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetProcedureData> dataDeserializer = (dynamic json)  => GetProcedureData.fromJson(jsonDecode(json));
  Serializer<GetProcedureVariables> varsSerializer = (GetProcedureVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetProcedureData, GetProcedureVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetProcedureData, GetProcedureVariables> ref() {
    GetProcedureVariables vars= GetProcedureVariables(id: id,);
    return _dataConnect.query("GetProcedure", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetProcedureProcedure {
  final String title;
  final Timestamp deadline;
  GetProcedureProcedure.fromJson(dynamic json):
  
  title = nativeFromJson<String>(json['title']),
  deadline = Timestamp.fromJson(json['deadline']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetProcedureProcedure otherTyped = other as GetProcedureProcedure;
    return title == otherTyped.title && 
    deadline == otherTyped.deadline;
    
  }
  @override
  int get hashCode => Object.hashAll([title.hashCode, deadline.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['title'] = nativeToJson<String>(title);
    json['deadline'] = deadline.toJson();
    return json;
  }

  const GetProcedureProcedure({
    required this.title,
    required this.deadline,
  });
}

@immutable
class GetProcedureData {
  final GetProcedureProcedure? procedure;
  GetProcedureData.fromJson(dynamic json):
  
  procedure = json['procedure'] == null ? null : GetProcedureProcedure.fromJson(json['procedure']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetProcedureData otherTyped = other as GetProcedureData;
    return procedure == otherTyped.procedure;
    
  }
  @override
  int get hashCode => procedure.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (procedure != null) {
      json['procedure'] = procedure!.toJson();
    }
    return json;
  }

  const GetProcedureData({
    this.procedure,
  });
}

@immutable
class GetProcedureVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetProcedureVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetProcedureVariables otherTyped = other as GetProcedureVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const GetProcedureVariables({
    required this.id,
  });
}

