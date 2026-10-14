part of 'generated.dart';

class DeleteUserDataVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  DeleteUserDataVariablesBuilder(this._dataConnect, );
  Deserializer<DeleteUserDataData> dataDeserializer = (dynamic json)  => DeleteUserDataData.fromJson(jsonDecode(json));
  
  Future<OperationResult<DeleteUserDataData, void>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteUserDataData, void> ref() {
    
    return _dataConnect.mutation("DeleteUserData", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class DeleteUserDataUserDelete {
  final String id;
  DeleteUserDataUserDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteUserDataUserDelete otherTyped = other as DeleteUserDataUserDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteUserDataUserDelete({
    required this.id,
  });
}

@immutable
class DeleteUserDataData {
  final DeleteUserDataUserDelete? user_delete;
  DeleteUserDataData.fromJson(dynamic json):
  
  user_delete = json['user_delete'] == null ? null : DeleteUserDataUserDelete.fromJson(json['user_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteUserDataData otherTyped = other as DeleteUserDataData;
    return user_delete == otherTyped.user_delete;
    
  }
  @override
  int get hashCode => user_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user_delete != null) {
      json['user_delete'] = user_delete!.toJson();
    }
    return json;
  }

  const DeleteUserDataData({
    this.user_delete,
  });
}

