part of 'generated.dart';

class GetChatHistoryVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetChatHistoryVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetChatHistoryData> dataDeserializer = (dynamic json)  => GetChatHistoryData.fromJson(jsonDecode(json));
  Serializer<GetChatHistoryVariables> varsSerializer = (GetChatHistoryVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetChatHistoryData, GetChatHistoryVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetChatHistoryData, GetChatHistoryVariables> ref() {
    GetChatHistoryVariables vars= GetChatHistoryVariables(id: id,);
    return _dataConnect.query("GetChatHistory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetChatHistoryChatHistory {
  final String prompt;
  final String response;
  GetChatHistoryChatHistory.fromJson(dynamic json):
  
  prompt = nativeFromJson<String>(json['prompt']),
  response = nativeFromJson<String>(json['response']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetChatHistoryChatHistory otherTyped = other as GetChatHistoryChatHistory;
    return prompt == otherTyped.prompt && 
    response == otherTyped.response;
    
  }
  @override
  int get hashCode => Object.hashAll([prompt.hashCode, response.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['prompt'] = nativeToJson<String>(prompt);
    json['response'] = nativeToJson<String>(response);
    return json;
  }

  const GetChatHistoryChatHistory({
    required this.prompt,
    required this.response,
  });
}

@immutable
class GetChatHistoryData {
  final GetChatHistoryChatHistory? chatHistory;
  GetChatHistoryData.fromJson(dynamic json):
  
  chatHistory = json['chatHistory'] == null ? null : GetChatHistoryChatHistory.fromJson(json['chatHistory']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetChatHistoryData otherTyped = other as GetChatHistoryData;
    return chatHistory == otherTyped.chatHistory;
    
  }
  @override
  int get hashCode => chatHistory.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (chatHistory != null) {
      json['chatHistory'] = chatHistory!.toJson();
    }
    return json;
  }

  const GetChatHistoryData({
    this.chatHistory,
  });
}

@immutable
class GetChatHistoryVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetChatHistoryVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetChatHistoryVariables otherTyped = other as GetChatHistoryVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const GetChatHistoryVariables({
    required this.id,
  });
}

