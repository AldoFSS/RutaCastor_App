part of 'generated.dart';

class ListProceduresVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListProceduresVariablesBuilder(this._dataConnect, );
  Deserializer<ListProceduresData> dataDeserializer = (dynamic json)  => ListProceduresData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListProceduresData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListProceduresData, void> ref() {
    
    return _dataConnect.query("ListProcedures", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListProceduresProcedures {
  final String title;
  final Timestamp deadline;
  ListProceduresProcedures.fromJson(dynamic json):
  
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

    final ListProceduresProcedures otherTyped = other as ListProceduresProcedures;
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

  const ListProceduresProcedures({
    required this.title,
    required this.deadline,
  });
}

@immutable
class ListProceduresData {
  final List<ListProceduresProcedures> procedures;
  ListProceduresData.fromJson(dynamic json):
  
  procedures = (json['procedures'] as List<dynamic>)
        .map((e) => ListProceduresProcedures.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListProceduresData otherTyped = other as ListProceduresData;
    return procedures == otherTyped.procedures;
    
  }
  @override
  int get hashCode => procedures.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['procedures'] = procedures.map((e) => e.toJson()).toList();
    return json;
  }

  const ListProceduresData({
    required this.procedures,
  });
}

