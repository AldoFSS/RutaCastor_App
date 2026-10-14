part of 'generated.dart';

class UpdateEventVariablesBuilder {
  String id;
  String title;

  final FirebaseDataConnect _dataConnect;
  UpdateEventVariablesBuilder(this._dataConnect, {required  this.id,required  this.title,});
  Deserializer<UpdateEventData> dataDeserializer = (dynamic json)  => UpdateEventData.fromJson(jsonDecode(json));
  Serializer<UpdateEventVariables> varsSerializer = (UpdateEventVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateEventData, UpdateEventVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateEventData, UpdateEventVariables> ref() {
    UpdateEventVariables vars= UpdateEventVariables(id: id,title: title,);
    return _dataConnect.mutation("UpdateEvent", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateEventEventUpdate {
  final String id;
  UpdateEventEventUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateEventEventUpdate otherTyped = other as UpdateEventEventUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const UpdateEventEventUpdate({
    required this.id,
  });
}

@immutable
class UpdateEventData {
  final UpdateEventEventUpdate? event_update;
  UpdateEventData.fromJson(dynamic json):
  
  event_update = json['event_update'] == null ? null : UpdateEventEventUpdate.fromJson(json['event_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateEventData otherTyped = other as UpdateEventData;
    return event_update == otherTyped.event_update;
    
  }
  @override
  int get hashCode => event_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (event_update != null) {
      json['event_update'] = event_update!.toJson();
    }
    return json;
  }

  const UpdateEventData({
    this.event_update,
  });
}

@immutable
class UpdateEventVariables {
  final String id;
  final String title;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateEventVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  title = nativeFromJson<String>(json['title']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateEventVariables otherTyped = other as UpdateEventVariables;
    return id == otherTyped.id && 
    title == otherTyped.title;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, title.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['title'] = nativeToJson<String>(title);
    return json;
  }

  const UpdateEventVariables({
    required this.id,
    required this.title,
  });
}

