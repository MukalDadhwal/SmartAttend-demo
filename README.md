# smartattend_app

A new Flutter project.


## Run the socket

```
cd chatapp
npm start 
```
this starts the socket at port 3000

## Run the flutter app

```
flutter run -d <device-id>
```

## Main packages used

- socket_io_client: to connect with the socket io client running on port 3000

- awesome_notifications: to show notifications on the foreground

- flutter_background_service: for running a background task on a different thread which shows the notification 

- get_it: service locator for handling background service

- flutter_riverpod: gives a streamprovider for listening to the socket
# SmartAttend-demo
