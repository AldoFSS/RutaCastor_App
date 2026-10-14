import { ConnectorConfig, DataConnect, OperationOptions, ExecuteOperationResponse } from 'firebase-admin/data-connect';

export const connectorConfig: ConnectorConfig;

export type TimestampString = string;
export type UUIDString = string;
export type Int64String = string;
export type DateString = string;


export interface Building_Key {
  id: UUIDString;
  __typename?: 'Building_Key';
}

export interface ChatHistory_Key {
  id: UUIDString;
  __typename?: 'ChatHistory_Key';
}

export interface CreateBuildingData {
  building_insert: Building_Key;
}

export interface CreateChatHistoryData {
  chatHistory_insert: ChatHistory_Key;
}

export interface CreateChatHistoryVariables {
  prompt: string;
  resp: string;
}

export interface CreateEventData {
  event_insert: Event_Key;
}

export interface CreateEventVariables {
  locId: UUIDString;
}

export interface CreateProcedureData {
  procedure_insert: Procedure_Key;
}

export interface CreateUserDataData {
  user_insert: User_Key;
}

export interface DeleteBuildingData {
  building_delete?: Building_Key | null;
}

export interface DeleteBuildingVariables {
  id: UUIDString;
}

export interface DeleteChatHistoryData {
  chatHistory_delete?: ChatHistory_Key | null;
}

export interface DeleteChatHistoryVariables {
  id: UUIDString;
}

export interface DeleteEventData {
  event_delete?: Event_Key | null;
}

export interface DeleteEventVariables {
  id: UUIDString;
}

export interface DeleteProcedureData {
  procedure_delete?: Procedure_Key | null;
}

export interface DeleteProcedureVariables {
  id: UUIDString;
}

export interface DeleteUserDataData {
  user_delete?: User_Key | null;
}

export interface Event_Key {
  id: UUIDString;
  __typename?: 'Event_Key';
}

export interface GetBuildingData {
  building?: {
    name: string;
    latitude: number;
    longitude: number;
    description?: string | null;
  };
}

export interface GetBuildingVariables {
  id: UUIDString;
}

export interface GetChatHistoryData {
  chatHistory?: {
    prompt: string;
    response: string;
  };
}

export interface GetChatHistoryVariables {
  id: UUIDString;
}

export interface GetEventData {
  event?: {
    title: string;
    date: TimestampString;
    location: {
      name: string;
    };
  };
}

export interface GetEventVariables {
  id: UUIDString;
}

export interface GetProcedureData {
  procedure?: {
    title: string;
    deadline: TimestampString;
  };
}

export interface GetProcedureVariables {
  id: UUIDString;
}

export interface GetUserDataData {
  user?: {
    id: UUIDString;
    email: string;
    role: string;
    career?: string | null;
  } & User_Key;
}

export interface ListBuildingsData {
  buildings: ({
    name: string;
    category?: string | null;
  })[];
}

export interface ListEventsData {
  events: ({
    title: string;
    date: TimestampString;
  })[];
}

export interface ListMyChatHistoryData {
  chatHistories: ({
    prompt: string;
    timestamp: TimestampString;
  })[];
}

export interface ListProceduresData {
  procedures: ({
    title: string;
    deadline: TimestampString;
  })[];
}

export interface ListUsersData {
  users: ({
    id: UUIDString;
    email: string;
    role: string;
  } & User_Key)[];
}

export interface Procedure_Key {
  id: UUIDString;
  __typename?: 'Procedure_Key';
}

export interface UpdateBuildingData {
  building_update?: Building_Key | null;
}

export interface UpdateBuildingVariables {
  id: UUIDString;
}

export interface UpdateEventData {
  event_update?: Event_Key | null;
}

export interface UpdateEventVariables {
  id: UUIDString;
  title: string;
}

export interface UpdateProcedureData {
  procedure_update?: Procedure_Key | null;
}

export interface UpdateProcedureVariables {
  id: UUIDString;
  desc: string;
}

export interface UpdateUserDataData {
  user_update?: User_Key | null;
}

export interface User_Key {
  id: UUIDString;
  __typename?: 'User_Key';
}

/** Generated Node Admin SDK operation action function for the 'CreateUserData' Mutation. Allow users to execute without passing in DataConnect. */
export function createUserData(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateUserDataData>>;
/** Generated Node Admin SDK operation action function for the 'CreateUserData' Mutation. Allow users to pass in custom DataConnect instances. */
export function createUserData(options?: OperationOptions): Promise<ExecuteOperationResponse<CreateUserDataData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateUserData' Mutation. Allow users to execute without passing in DataConnect. */
export function updateUserData(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateUserDataData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateUserData' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateUserData(options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateUserDataData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteUserData' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteUserData(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteUserDataData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteUserData' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteUserData(options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteUserDataData>>;

/** Generated Node Admin SDK operation action function for the 'GetUserData' Query. Allow users to execute without passing in DataConnect. */
export function getUserData(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<GetUserDataData>>;
/** Generated Node Admin SDK operation action function for the 'GetUserData' Query. Allow users to pass in custom DataConnect instances. */
export function getUserData(options?: OperationOptions): Promise<ExecuteOperationResponse<GetUserDataData>>;

/** Generated Node Admin SDK operation action function for the 'ListUsers' Query. Allow users to execute without passing in DataConnect. */
export function listUsers(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListUsersData>>;
/** Generated Node Admin SDK operation action function for the 'ListUsers' Query. Allow users to pass in custom DataConnect instances. */
export function listUsers(options?: OperationOptions): Promise<ExecuteOperationResponse<ListUsersData>>;

/** Generated Node Admin SDK operation action function for the 'CreateBuilding' Mutation. Allow users to execute without passing in DataConnect. */
export function createBuilding(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateBuildingData>>;
/** Generated Node Admin SDK operation action function for the 'CreateBuilding' Mutation. Allow users to pass in custom DataConnect instances. */
export function createBuilding(options?: OperationOptions): Promise<ExecuteOperationResponse<CreateBuildingData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateBuilding' Mutation. Allow users to execute without passing in DataConnect. */
export function updateBuilding(dc: DataConnect, vars: UpdateBuildingVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateBuildingData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateBuilding' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateBuilding(vars: UpdateBuildingVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateBuildingData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteBuilding' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteBuilding(dc: DataConnect, vars: DeleteBuildingVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteBuildingData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteBuilding' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteBuilding(vars: DeleteBuildingVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteBuildingData>>;

/** Generated Node Admin SDK operation action function for the 'GetBuilding' Query. Allow users to execute without passing in DataConnect. */
export function getBuilding(dc: DataConnect, vars: GetBuildingVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetBuildingData>>;
/** Generated Node Admin SDK operation action function for the 'GetBuilding' Query. Allow users to pass in custom DataConnect instances. */
export function getBuilding(vars: GetBuildingVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetBuildingData>>;

/** Generated Node Admin SDK operation action function for the 'ListBuildings' Query. Allow users to execute without passing in DataConnect. */
export function listBuildings(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListBuildingsData>>;
/** Generated Node Admin SDK operation action function for the 'ListBuildings' Query. Allow users to pass in custom DataConnect instances. */
export function listBuildings(options?: OperationOptions): Promise<ExecuteOperationResponse<ListBuildingsData>>;

/** Generated Node Admin SDK operation action function for the 'CreateProcedure' Mutation. Allow users to execute without passing in DataConnect. */
export function createProcedure(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateProcedureData>>;
/** Generated Node Admin SDK operation action function for the 'CreateProcedure' Mutation. Allow users to pass in custom DataConnect instances. */
export function createProcedure(options?: OperationOptions): Promise<ExecuteOperationResponse<CreateProcedureData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateProcedure' Mutation. Allow users to execute without passing in DataConnect. */
export function updateProcedure(dc: DataConnect, vars: UpdateProcedureVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateProcedureData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateProcedure' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateProcedure(vars: UpdateProcedureVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateProcedureData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteProcedure' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteProcedure(dc: DataConnect, vars: DeleteProcedureVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteProcedureData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteProcedure' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteProcedure(vars: DeleteProcedureVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteProcedureData>>;

/** Generated Node Admin SDK operation action function for the 'GetProcedure' Query. Allow users to execute without passing in DataConnect. */
export function getProcedure(dc: DataConnect, vars: GetProcedureVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetProcedureData>>;
/** Generated Node Admin SDK operation action function for the 'GetProcedure' Query. Allow users to pass in custom DataConnect instances. */
export function getProcedure(vars: GetProcedureVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetProcedureData>>;

/** Generated Node Admin SDK operation action function for the 'ListProcedures' Query. Allow users to execute without passing in DataConnect. */
export function listProcedures(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListProceduresData>>;
/** Generated Node Admin SDK operation action function for the 'ListProcedures' Query. Allow users to pass in custom DataConnect instances. */
export function listProcedures(options?: OperationOptions): Promise<ExecuteOperationResponse<ListProceduresData>>;

/** Generated Node Admin SDK operation action function for the 'CreateEvent' Mutation. Allow users to execute without passing in DataConnect. */
export function createEvent(dc: DataConnect, vars: CreateEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateEventData>>;
/** Generated Node Admin SDK operation action function for the 'CreateEvent' Mutation. Allow users to pass in custom DataConnect instances. */
export function createEvent(vars: CreateEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateEventData>>;

/** Generated Node Admin SDK operation action function for the 'UpdateEvent' Mutation. Allow users to execute without passing in DataConnect. */
export function updateEvent(dc: DataConnect, vars: UpdateEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateEventData>>;
/** Generated Node Admin SDK operation action function for the 'UpdateEvent' Mutation. Allow users to pass in custom DataConnect instances. */
export function updateEvent(vars: UpdateEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<UpdateEventData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteEvent' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteEvent(dc: DataConnect, vars: DeleteEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteEventData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteEvent' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteEvent(vars: DeleteEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteEventData>>;

/** Generated Node Admin SDK operation action function for the 'GetEvent' Query. Allow users to execute without passing in DataConnect. */
export function getEvent(dc: DataConnect, vars: GetEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetEventData>>;
/** Generated Node Admin SDK operation action function for the 'GetEvent' Query. Allow users to pass in custom DataConnect instances. */
export function getEvent(vars: GetEventVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetEventData>>;

/** Generated Node Admin SDK operation action function for the 'ListEvents' Query. Allow users to execute without passing in DataConnect. */
export function listEvents(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListEventsData>>;
/** Generated Node Admin SDK operation action function for the 'ListEvents' Query. Allow users to pass in custom DataConnect instances. */
export function listEvents(options?: OperationOptions): Promise<ExecuteOperationResponse<ListEventsData>>;

/** Generated Node Admin SDK operation action function for the 'CreateChatHistory' Mutation. Allow users to execute without passing in DataConnect. */
export function createChatHistory(dc: DataConnect, vars: CreateChatHistoryVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateChatHistoryData>>;
/** Generated Node Admin SDK operation action function for the 'CreateChatHistory' Mutation. Allow users to pass in custom DataConnect instances. */
export function createChatHistory(vars: CreateChatHistoryVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<CreateChatHistoryData>>;

/** Generated Node Admin SDK operation action function for the 'DeleteChatHistory' Mutation. Allow users to execute without passing in DataConnect. */
export function deleteChatHistory(dc: DataConnect, vars: DeleteChatHistoryVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteChatHistoryData>>;
/** Generated Node Admin SDK operation action function for the 'DeleteChatHistory' Mutation. Allow users to pass in custom DataConnect instances. */
export function deleteChatHistory(vars: DeleteChatHistoryVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<DeleteChatHistoryData>>;

/** Generated Node Admin SDK operation action function for the 'GetChatHistory' Query. Allow users to execute without passing in DataConnect. */
export function getChatHistory(dc: DataConnect, vars: GetChatHistoryVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetChatHistoryData>>;
/** Generated Node Admin SDK operation action function for the 'GetChatHistory' Query. Allow users to pass in custom DataConnect instances. */
export function getChatHistory(vars: GetChatHistoryVariables, options?: OperationOptions): Promise<ExecuteOperationResponse<GetChatHistoryData>>;

/** Generated Node Admin SDK operation action function for the 'ListMyChatHistory' Query. Allow users to execute without passing in DataConnect. */
export function listMyChatHistory(dc: DataConnect, options?: OperationOptions): Promise<ExecuteOperationResponse<ListMyChatHistoryData>>;
/** Generated Node Admin SDK operation action function for the 'ListMyChatHistory' Query. Allow users to pass in custom DataConnect instances. */
export function listMyChatHistory(options?: OperationOptions): Promise<ExecuteOperationResponse<ListMyChatHistoryData>>;

