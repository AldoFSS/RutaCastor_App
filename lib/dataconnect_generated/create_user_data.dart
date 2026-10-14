part of 'generated.dart';

class CreateUserDataVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  CreateUserDataVariablesBuilder(this._dataConnect, );
  Deserializer<CreateUserDataData> dataDeserializer = (dynamic json)  => CreateUserDataData.fromJson(jsonDecode(json));
  
  Future<OperationResult<CreateUserDataData, void>> execute() {
    return ref().execute();
  }

  MutationRef<CreateUserDataData, void> ref() {
    
    return _dataConnect.mutation("CreateUserData", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class CreateUserDataUserInsert {
  final String id;
  CreateUserDataUserInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserDataUserInsert otherTyped = other as CreateUserDataUserInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const CreateUserDataUserInsert({
    required this.id,
  });
}

@immutable
class CreateUserDataData {
  final CreateUserDataUserInsert user_insert;
  CreateUserDataData.fromJson(dynamic json):
  
  user_insert = CreateUserDataUserInsert.fromJson(json['user_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateUserDataData otherTyped = other as CreateUserDataData;
    return user_insert == otherTyped.user_insert;
    
  }
  @override
  int get hashCode => user_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_insert'] = user_insert.toJson();
    return json;
  }

  const CreateUserDataData({
    required this.user_insert,
  });
}

