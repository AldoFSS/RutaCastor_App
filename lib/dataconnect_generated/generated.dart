library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_user_data.dart';

part 'update_user_data.dart';

part 'delete_user_data.dart';

part 'get_user_data.dart';

part 'list_users.dart';

part 'create_building.dart';

part 'update_building.dart';

part 'delete_building.dart';

part 'get_building.dart';

part 'list_buildings.dart';

part 'create_procedure.dart';

part 'update_procedure.dart';

part 'delete_procedure.dart';

part 'get_procedure.dart';

part 'list_procedures.dart';

part 'create_event.dart';

part 'update_event.dart';

part 'delete_event.dart';

part 'get_event.dart';

part 'list_events.dart';

part 'create_chat_history.dart';

part 'delete_chat_history.dart';

part 'get_chat_history.dart';

part 'list_my_chat_history.dart';







class ExampleConnector {
  
  
  CreateUserDataVariablesBuilder createUserData () {
    return CreateUserDataVariablesBuilder(dataConnect, );
  }
  
  
  UpdateUserDataVariablesBuilder updateUserData () {
    return UpdateUserDataVariablesBuilder(dataConnect, );
  }
  
  
  DeleteUserDataVariablesBuilder deleteUserData () {
    return DeleteUserDataVariablesBuilder(dataConnect, );
  }
  
  
  GetUserDataVariablesBuilder getUserData () {
    return GetUserDataVariablesBuilder(dataConnect, );
  }
  
  
  ListUsersVariablesBuilder listUsers () {
    return ListUsersVariablesBuilder(dataConnect, );
  }
  
  
  CreateBuildingVariablesBuilder createBuilding () {
    return CreateBuildingVariablesBuilder(dataConnect, );
  }
  
  
  UpdateBuildingVariablesBuilder updateBuilding ({required String id, }) {
    return UpdateBuildingVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteBuildingVariablesBuilder deleteBuilding ({required String id, }) {
    return DeleteBuildingVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetBuildingVariablesBuilder getBuilding ({required String id, }) {
    return GetBuildingVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListBuildingsVariablesBuilder listBuildings () {
    return ListBuildingsVariablesBuilder(dataConnect, );
  }
  
  
  CreateProcedureVariablesBuilder createProcedure () {
    return CreateProcedureVariablesBuilder(dataConnect, );
  }
  
  
  UpdateProcedureVariablesBuilder updateProcedure ({required String id, required String desc, }) {
    return UpdateProcedureVariablesBuilder(dataConnect, id: id,desc: desc,);
  }
  
  
  DeleteProcedureVariablesBuilder deleteProcedure ({required String id, }) {
    return DeleteProcedureVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetProcedureVariablesBuilder getProcedure ({required String id, }) {
    return GetProcedureVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListProceduresVariablesBuilder listProcedures () {
    return ListProceduresVariablesBuilder(dataConnect, );
  }
  
  
  CreateEventVariablesBuilder createEvent ({required String locId, }) {
    return CreateEventVariablesBuilder(dataConnect, locId: locId,);
  }
  
  
  UpdateEventVariablesBuilder updateEvent ({required String id, required String title, }) {
    return UpdateEventVariablesBuilder(dataConnect, id: id,title: title,);
  }
  
  
  DeleteEventVariablesBuilder deleteEvent ({required String id, }) {
    return DeleteEventVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetEventVariablesBuilder getEvent ({required String id, }) {
    return GetEventVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListEventsVariablesBuilder listEvents () {
    return ListEventsVariablesBuilder(dataConnect, );
  }
  
  
  CreateChatHistoryVariablesBuilder createChatHistory ({required String prompt, required String resp, }) {
    return CreateChatHistoryVariablesBuilder(dataConnect, prompt: prompt,resp: resp,);
  }
  
  
  DeleteChatHistoryVariablesBuilder deleteChatHistory ({required String id, }) {
    return DeleteChatHistoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetChatHistoryVariablesBuilder getChatHistory ({required String id, }) {
    return GetChatHistoryVariablesBuilder(dataConnect, id: id,);
  }
  
  
  ListMyChatHistoryVariablesBuilder listMyChatHistory () {
    return ListMyChatHistoryVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'example',
    'rutacastorapp',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: const Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
