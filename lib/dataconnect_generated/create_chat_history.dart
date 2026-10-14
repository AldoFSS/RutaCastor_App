part of 'generated.dart';

class CreateChatHistoryVariablesBuilder {
  String prompt;
  String resp;

  final FirebaseDataConnect _dataConnect;
  CreateChatHistoryVariablesBuilder(this._dataConnect, {required  this.prompt,required  this.resp,});
  Deserializer<CreateChatHistoryData> dataDeserializer = (dynamic json)  => CreateChatHistoryData.fromJson(jsonDecode(json));
  Serializer<CreateChatHistoryVariables> varsSerializer = (CreateChatHistoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateChatHistoryData, CreateChatHistoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateChatHistoryData, CreateChatHistoryVariables> ref() {
    CreateChatHistoryVariables vars= CreateChatHistoryVariables(prompt: prompt,resp: resp,);
    return _dataConnect.mutation("CreateChatHistory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateChatHistoryChatHistoryInsert {
  final String id;
  CreateChatHistoryChatHistoryInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateChatHistoryChatHistoryInsert otherTyped = other as CreateChatHistoryChatHistoryInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const CreateChatHistoryChatHistoryInsert({
    required this.id,
  });
}

@immutable
class CreateChatHistoryData {
  final CreateChatHistoryChatHistoryInsert chatHistory_insert;
  CreateChatHistoryData.fromJson(dynamic json):
  
  chatHistory_insert = CreateChatHistoryChatHistoryInsert.fromJson(json['chatHistory_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateChatHistoryData otherTyped = other as CreateChatHistoryData;
    return chatHistory_insert == otherTyped.chatHistory_insert;
    
  }
  @override
  int get hashCode => chatHistory_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['chatHistory_insert'] = chatHistory_insert.toJson();
    return json;
  }

  const CreateChatHistoryData({
    required this.chatHistory_insert,
  });
}

@immutable
class CreateChatHistoryVariables {
  final String prompt;
  final String resp;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateChatHistoryVariables.fromJson(Map<String, dynamic> json):
  
  prompt = nativeFromJson<String>(json['prompt']),
  resp = nativeFromJson<String>(json['resp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateChatHistoryVariables otherTyped = other as CreateChatHistoryVariables;
    return prompt == otherTyped.prompt && 
    resp == otherTyped.resp;
    
  }
  @override
  int get hashCode => Object.hashAll([prompt.hashCode, resp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['prompt'] = nativeToJson<String>(prompt);
    json['resp'] = nativeToJson<String>(resp);
    return json;
  }

  const CreateChatHistoryVariables({
    required this.prompt,
    required this.resp,
  });
}

