part of 'generated.dart';

class DeleteChatHistoryVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteChatHistoryVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteChatHistoryData> dataDeserializer = (dynamic json)  => DeleteChatHistoryData.fromJson(jsonDecode(json));
  Serializer<DeleteChatHistoryVariables> varsSerializer = (DeleteChatHistoryVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteChatHistoryData, DeleteChatHistoryVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteChatHistoryData, DeleteChatHistoryVariables> ref() {
    DeleteChatHistoryVariables vars= DeleteChatHistoryVariables(id: id,);
    return _dataConnect.mutation("DeleteChatHistory", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteChatHistoryChatHistoryDelete {
  final String id;
  DeleteChatHistoryChatHistoryDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteChatHistoryChatHistoryDelete otherTyped = other as DeleteChatHistoryChatHistoryDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteChatHistoryChatHistoryDelete({
    required this.id,
  });
}

@immutable
class DeleteChatHistoryData {
  final DeleteChatHistoryChatHistoryDelete? chatHistory_delete;
  DeleteChatHistoryData.fromJson(dynamic json):
  
  chatHistory_delete = json['chatHistory_delete'] == null ? null : DeleteChatHistoryChatHistoryDelete.fromJson(json['chatHistory_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteChatHistoryData otherTyped = other as DeleteChatHistoryData;
    return chatHistory_delete == otherTyped.chatHistory_delete;
    
  }
  @override
  int get hashCode => chatHistory_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (chatHistory_delete != null) {
      json['chatHistory_delete'] = chatHistory_delete!.toJson();
    }
    return json;
  }

  const DeleteChatHistoryData({
    this.chatHistory_delete,
  });
}

@immutable
class DeleteChatHistoryVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteChatHistoryVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteChatHistoryVariables otherTyped = other as DeleteChatHistoryVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  const DeleteChatHistoryVariables({
    required this.id,
  });
}

