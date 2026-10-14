part of 'generated.dart';

class UpdateUserDataVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  UpdateUserDataVariablesBuilder(this._dataConnect, );
  Deserializer<UpdateUserDataData> dataDeserializer = (dynamic json)  => UpdateUserDataData.fromJson(jsonDecode(json));
  
  Future<OperationResult<UpdateUserDataData, void>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateUserDataData, void> ref() {
    
    return _dataConnect.mutation("UpdateUserData", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class UpdateUserDataUserUpdate {
  final String id;
  UpdateUserDataUserUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserDataUserUpdate otherTyped = other as UpdateUserDataUserUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const UpdateUserDataUserUpdate({
    required this.id,
  });
}

@immutable
class UpdateUserDataData {
  final UpdateUserDataUserUpdate? user_update;
  UpdateUserDataData.fromJson(dynamic json):
  
  user_update = json['user_update'] == null ? null : UpdateUserDataUserUpdate.fromJson(json['user_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateUserDataData otherTyped = other as UpdateUserDataData;
    return user_update == otherTyped.user_update;
    
  }
  @override
  int get hashCode => user_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_update != null) {
      json['user_update'] = user_update!.toJson();
    }
    return json;
  }

  const UpdateUserDataData({
    this.user_update,
  });
}

