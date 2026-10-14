part of 'generated.dart';

class CreateEventVariablesBuilder {
  String locId;

  final FirebaseDataConnect _dataConnect;
  CreateEventVariablesBuilder(this._dataConnect, {required  this.locId,});
  Deserializer<CreateEventData> dataDeserializer = (dynamic json)  => CreateEventData.fromJson(jsonDecode(json));
  Serializer<CreateEventVariables> varsSerializer = (CreateEventVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateEventData, CreateEventVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateEventData, CreateEventVariables> ref() {
    CreateEventVariables vars= CreateEventVariables(locId: locId,);
    return _dataConnect.mutation("CreateEvent", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateEventEventInsert {
  final String id;
  CreateEventEventInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateEventEventInsert otherTyped = other as CreateEventEventInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const CreateEventEventInsert({
    required this.id,
  });
}

@immutable
class CreateEventData {
  final CreateEventEventInsert event_insert;
  CreateEventData.fromJson(dynamic json):
  
  event_insert = CreateEventEventInsert.fromJson(json['event_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateEventData otherTyped = other as CreateEventData;
    return event_insert == otherTyped.event_insert;
    
  }
  @override
  int get hashCode => event_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['event_insert'] = event_insert.toJson();
    return json;
  }

  const CreateEventData({
    required this.event_insert,
  });
}

@immutable
class CreateEventVariables {
  final String locId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateEventVariables.fromJson(Map<String, dynamic> json):
  
  locId = nativeFromJson<String>(json['locId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateEventVariables otherTyped = other as CreateEventVariables;
    return locId == otherTyped.locId;
    
  }
  @override
  int get hashCode => locId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['locId'] = nativeToJson<String>(locId);
    return json;
  }

  const CreateEventVariables({
    required this.locId,
  });
}

