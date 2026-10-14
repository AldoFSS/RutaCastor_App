part of 'generated.dart';

class GetUserDataVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetUserDataVariablesBuilder(this._dataConnect, );
  Deserializer<GetUserDataData> dataDeserializer = (dynamic json)  => GetUserDataData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetUserDataData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetUserDataData, void> ref() {
    
    return _dataConnect.query("GetUserData", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetUserDataUser {
  final String id;
  final String email;
  final String role;
  final String? career;
  GetUserDataUser.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  email = nativeFromJson<String>(json['email']),
  role = nativeFromJson<String>(json['role']),
  career = json['career'] == null ? null : nativeFromJson<String>(json['career']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserDataUser otherTyped = other as GetUserDataUser;
    return id == otherTyped.id && 
    email == otherTyped.email && 
    role == otherTyped.role && 
    career == otherTyped.career;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, email.hashCode, role.hashCode, career.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['email'] = nativeToJson<String>(email);
    json['role'] = nativeToJson<String>(role);
    if (career != null) {
      json['career'] = nativeToJson<String?>(career);
    }
    return json;
  }

  const GetUserDataUser({
    required this.id,
    required this.email,
    required this.role,
    this.career,
  });
}

@immutable
class GetUserDataData {
  final GetUserDataUser? user;
  GetUserDataData.fromJson(dynamic json):
  
  user = json['user'] == null ? null : GetUserDataUser.fromJson(json['user']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetUserDataData otherTyped = other as GetUserDataData;
    return user == otherTyped.user;
    
  }
  @override
  int get hashCode => user.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (user != null) {
      json['user'] = user!.toJson();
    }
    return json;
  }

  const GetUserDataData({
    this.user,
  });
}

