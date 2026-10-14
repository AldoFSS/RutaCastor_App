# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetUserData
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getUserData().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetUserDataData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getUserData();
GetUserDataData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getUserData().ref();
ref.execute();

ref.subscribe(...);
```


### ListUsers
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listUsers().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListUsersData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listUsers();
ListUsersData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listUsers().ref();
ref.execute();

ref.subscribe(...);
```


### GetBuilding
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getBuilding(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetBuildingData, GetBuildingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getBuilding(
  id: id,
);
GetBuildingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getBuilding(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListBuildings
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listBuildings().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListBuildingsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listBuildings();
ListBuildingsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listBuildings().ref();
ref.execute();

ref.subscribe(...);
```


### GetProcedure
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getProcedure(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetProcedureData, GetProcedureVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getProcedure(
  id: id,
);
GetProcedureData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getProcedure(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListProcedures
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listProcedures().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListProceduresData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listProcedures();
ListProceduresData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listProcedures().ref();
ref.execute();

ref.subscribe(...);
```


### GetEvent
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getEvent(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetEventData, GetEventVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getEvent(
  id: id,
);
GetEventData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getEvent(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListEvents
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listEvents().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListEventsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listEvents();
ListEventsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listEvents().ref();
ref.execute();

ref.subscribe(...);
```


### GetChatHistory
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.getChatHistory(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetChatHistoryData, GetChatHistoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getChatHistory(
  id: id,
);
GetChatHistoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.getChatHistory(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### ListMyChatHistory
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMyChatHistory().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMyChatHistoryData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMyChatHistory();
ListMyChatHistoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMyChatHistory().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateUserData
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.createUserData().execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateUserDataData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createUserData();
CreateUserDataData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.createUserData().ref();
ref.execute();
```


### UpdateUserData
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.updateUserData().execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateUserDataData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateUserData();
UpdateUserDataData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.updateUserData().ref();
ref.execute();
```


### DeleteUserData
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.deleteUserData().execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteUserDataData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteUserData();
DeleteUserDataData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.deleteUserData().ref();
ref.execute();
```


### CreateBuilding
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.createBuilding().execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateBuildingData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createBuilding();
CreateBuildingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.createBuilding().ref();
ref.execute();
```


### UpdateBuilding
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.updateBuilding(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateBuildingData, UpdateBuildingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateBuilding(
  id: id,
);
UpdateBuildingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.updateBuilding(
  id: id,
).ref();
ref.execute();
```


### DeleteBuilding
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteBuilding(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteBuildingData, DeleteBuildingVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteBuilding(
  id: id,
);
DeleteBuildingData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteBuilding(
  id: id,
).ref();
ref.execute();
```


### CreateProcedure
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.createProcedure().execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateProcedureData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createProcedure();
CreateProcedureData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.createProcedure().ref();
ref.execute();
```


### UpdateProcedure
#### Required Arguments
```dart
String id = ...;
String desc = ...;
ExampleConnector.instance.updateProcedure(
  id: id,
  desc: desc,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateProcedureData, UpdateProcedureVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateProcedure(
  id: id,
  desc: desc,
);
UpdateProcedureData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String desc = ...;

final ref = ExampleConnector.instance.updateProcedure(
  id: id,
  desc: desc,
).ref();
ref.execute();
```


### DeleteProcedure
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteProcedure(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteProcedureData, DeleteProcedureVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteProcedure(
  id: id,
);
DeleteProcedureData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteProcedure(
  id: id,
).ref();
ref.execute();
```


### CreateEvent
#### Required Arguments
```dart
String locId = ...;
ExampleConnector.instance.createEvent(
  locId: locId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateEventData, CreateEventVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createEvent(
  locId: locId,
);
CreateEventData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String locId = ...;

final ref = ExampleConnector.instance.createEvent(
  locId: locId,
).ref();
ref.execute();
```


### UpdateEvent
#### Required Arguments
```dart
String id = ...;
String title = ...;
ExampleConnector.instance.updateEvent(
  id: id,
  title: title,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<UpdateEventData, UpdateEventVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateEvent(
  id: id,
  title: title,
);
UpdateEventData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String title = ...;

final ref = ExampleConnector.instance.updateEvent(
  id: id,
  title: title,
).ref();
ref.execute();
```


### DeleteEvent
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteEvent(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteEventData, DeleteEventVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteEvent(
  id: id,
);
DeleteEventData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteEvent(
  id: id,
).ref();
ref.execute();
```


### CreateChatHistory
#### Required Arguments
```dart
String prompt = ...;
String resp = ...;
ExampleConnector.instance.createChatHistory(
  prompt: prompt,
  resp: resp,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateChatHistoryData, CreateChatHistoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createChatHistory(
  prompt: prompt,
  resp: resp,
);
CreateChatHistoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String prompt = ...;
String resp = ...;

final ref = ExampleConnector.instance.createChatHistory(
  prompt: prompt,
  resp: resp,
).ref();
ref.execute();
```


### DeleteChatHistory
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.deleteChatHistory(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<DeleteChatHistoryData, DeleteChatHistoryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.deleteChatHistory(
  id: id,
);
DeleteChatHistoryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.deleteChatHistory(
  id: id,
).ref();
ref.execute();
```

