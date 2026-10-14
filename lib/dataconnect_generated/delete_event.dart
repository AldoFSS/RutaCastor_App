part of 'generated.dart';

class DeleteEventVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteEventVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteEventData> dataDeserializer = (dynamic json)  => DeleteEventData.fromJson(jsonDecode(json));
  Serializer<DeleteEventVariables> varsSerializer = (DeleteEventVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteEventData, DeleteEventVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteEventData, DeleteEventVariables> ref() {
    DeleteEventVariables vars= DeleteEventVariables(id: id,);
    return _dataConnect.mutation("DeleteEvent", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteEventEventDelete {
  final String id;
  DeleteEventEventDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteEventEventDelete otherTyped = other as DeleteEventEventDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteEventEventDelete({
    required this.id,
  });
}

@immutable
class DeleteEventData {
  final DeleteEventEventDelete? event_delete;
  DeleteEventData.fromJson(dynamic json):
  
  event_delete = json['event_delete'] == null ? null : DeleteEventEventDelete.fromJson(json['event_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteEventData otherTyped = other as DeleteEventData;
    return event_delete == otherTyped.event_delete;
    
  }
  @override
  int get hashCode => event_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (event_delete != null) {
      json['event_delete'] = event_delete!.toJson();
    }
    return json;
  }

  const DeleteEventData({
    this.event_delete,
  });
}

@immutable
class DeleteEventVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteEventVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteEventVariables otherTyped = other as DeleteEventVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteEventVariables({
    required this.id,
  });
}

