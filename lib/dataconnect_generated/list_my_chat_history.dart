part of 'generated.dart';

class ListMyChatHistoryVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  ListMyChatHistoryVariablesBuilder(this._dataConnect, );
  Deserializer<ListMyChatHistoryData> dataDeserializer = (dynamic json)  => ListMyChatHistoryData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListMyChatHistoryData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<ListMyChatHistoryData, void> ref() {
    
    return _dataConnect.query("ListMyChatHistory", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class ListMyChatHistoryChatHistories {
  final String prompt;
  final Timestamp timestamp;
  ListMyChatHistoryChatHistories.fromJson(dynamic json):
  
  prompt = nativeFromJson<String>(json['prompt']),
  timestamp = Timestamp.fromJson(json['timestamp']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyChatHistoryChatHistories otherTyped = other as ListMyChatHistoryChatHistories;
    return prompt == otherTyped.prompt && 
    timestamp == otherTyped.timestamp;
    
  }
  @override
  int get hashCode => Object.hashAll([prompt.hashCode, timestamp.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['prompt'] = nativeToJson<String>(prompt);
    json['timestamp'] = timestamp.toJson();
    return json;
  }

  const ListMyChatHistoryChatHistories({
    required this.prompt,
    required this.timestamp,
  });
}

@immutable
class ListMyChatHistoryData {
  final List<ListMyChatHistoryChatHistories> chatHistories;
  ListMyChatHistoryData.fromJson(dynamic json):
  
  chatHistories = (json['chatHistories'] as List<dynamic>)
        .map((e) => ListMyChatHistoryChatHistories.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ListMyChatHistoryData otherTyped = other as ListMyChatHistoryData;
    return chatHistories == otherTyped.chatHistories;
    
  }
  @override
  int get hashCode => chatHistories.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['chatHistories'] = chatHistories.map((e) => e.toJson()).toList();
    return json;
  }

  const ListMyChatHistoryData({
    required this.chatHistories,
  });
}

