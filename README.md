## Installation

### External map links

#### iOS
To enable the handling of map links, include the following key to the `info.plist` file.

	<key>LSApplicationQueriesSchemes</key>
    <array>
        <string>geo</string>
        <string>comgooglemaps</string>
    </array>

#### Android

To enable the handling of map links, include the following key to the `Main/AndroidManifest.xml` file.

    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="geo" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>
    
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="comgooglemaps" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>

### Firebase notifications

In order to receive push notifications from firebase, add the following code to state of your MainApp
widget. This is the widget called in `main.dart`. 

    class _MyAppState extends State<MyApp> {
      late final FirebaseMessaging _messaging;
      int _totalNotifications = 0;
      PushNotification? _notificationInfo;
    
      @override
      void initState() {
        // For handling notification when the app is in background
        // but not terminated
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body'],
          );
          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
        });
    
        initializeFirebase().then((value) {
          registerNotification();
          checkForInitialMessage();
        });
    
        super.initState();
      }
    
      Future<void> initializeFirebase() async {
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      }
    
      // For handling notification when the app is in terminated state
      void checkForInitialMessage() async {
        RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    
        if (initialMessage != null) {
          PushNotification notification = PushNotification(
            title: initialMessage.notification?.title,
            body: initialMessage.notification?.body,
            dataTitle: initialMessage.data['title'],
            dataBody: initialMessage.data['body'],
          );
          setState(() {
            _notificationInfo = notification;
            _totalNotifications++;
          });
        }
      }
    
      void registerNotification() async {
        // 2. Instantiate Firebase Messaging
        _messaging = FirebaseMessaging.instance;
    
        _messaging.getToken().then((token) {
          debugPrint("Firebase PN token: \"" + token! + "\"");
        });
    
        // 3. On iOS, this helps to take the user permissions
        NotificationSettings settings = await _messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          carPlay: true,
          announcement: true
        );
    
        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          debugPrint('User granted permission');
    
          // For handling the received notifications
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            // Parse the message received
            PushNotification notification = PushNotification(
              title: message.notification?.title,
              body: message.notification?.body,
              dataTitle: message.data['title'],
              dataBody: message.data['body'],
            );
    
            setState(() {
              _notificationInfo = notification;
            });
    
            if (_notificationInfo != null) {
              // For displaying the notification as an overlay
              showSimpleNotification(
                Text(_notificationInfo!.title!),
                leading: NotificationBadge(totalNotifications: _totalNotifications),
                subtitle: Text(_notificationInfo!.body!),
                background: Colors.cyan.shade700,
                autoDismiss: false,
                slideDismissDirection: DismissDirection.down,
                position: NotificationPosition.bottom,
              );
            }
          });
    
          // Add the following line
          FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
        } else {
          debugPrint('User declined or has not accepted permission');
        }
      }
    
      @override
      Widget build(BuildContext context) {
        // Todo: add your build method here
      }
    }

#### Android

To enable receiving push notifications, add this to the `AndroidManifest`

    <intent-filter>
        <action android:name="FLUTTER_NOTIFICATION_CLICK" />
        <category android:name="android.intent.category.DEFAULT" />
    </intent-filter>

Download the `google_services.json` file, by following the instructions found here 
https://firebase.google.com/docs/android/setup. This file should be added under `/android/app/`

### Device location

#### iOS

Add the following permissiong to the `info.plist` file

	<key>NSLocationWhenInUseUsageDescription</key>
	<true/>

This will allow the app to request the device's location while being on the foreground. Requesting 
the location on the background has not been tested. Check out the documentation for the `location` 
package, to see the other permissions necessary to get the location in the background. 
https://pub.dev/packages/location
