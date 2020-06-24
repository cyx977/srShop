import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/products_grid.dart';

void contactSearch({String query}) async {
  if (await Permission.contacts.request().isGranted) {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(query: query);
    contacts.toList().forEach((element) {
      var numbers = element.phones.map((e) => e.value).toList();
      print("${element.displayName}: ${numbers[0]}");
    });
  }
}

void writeTest() async {
  if (await Permission.notification.request().isGranted) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id..', 'your channel name.', 'your channel description..',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(2, "First Notification",
        "THis is a stupid notification", platformChannelSpecifics);
  } else {
    print("not granted");
  }
  // DownloadsPathProvider.downloadsDirectory.then((value) => print(value));
  // getApplicationSupportDirectory().then((value) => print(value));
  // File("/storage/emulated/0/test.txt").create();
}

class ProductsOverviewScreen extends StatelessWidget {
  void recordStart() async {
    if (await Permission.microphone.request().isGranted &&
        await Permission.storage.request().isGranted) {
      // print("Mic and Storage Granted");
      var x = await DownloadsPathProvider.downloadsDirectory;
      var recorder = FlutterAudioRecorder(
        "${x.path}/santosh1",
        sampleRate: 22000,
        audioFormat: AudioFormat.WAV,
      ); // .wav .aac .m4a
      await recorder.initialized;
      await recorder.start();
      // var recording = await recorder.current(channel: 0);
    }
  }

  void recordStop() async {
    var x = await DownloadsPathProvider.downloadsDirectory;
    var recorder = FlutterAudioRecorder(
      "${x.path}/santosh",
      sampleRate: 22000,
      audioFormat: AudioFormat.AAC,
    ); // .wav .aac .m4a
    await recorder.stop();
  }

  static const String route = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Casual"),
        actions: [
          IconButton(
            icon: Icon(Icons.accessibility),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: ProductsGrid(),
          ),
          RaisedButton(
            onPressed: () {
              contactSearch(query: "pra");
            },
            child: Text("Contact Search"),
          ),
          RaisedButton(
            onPressed: writeTest,
            child: Text("Notification"),
          ),
          RaisedButton(
            onPressed: recordStart,
            child: Text("Record-Start"),
          ),
          RaisedButton(
            onPressed: recordStop,
            child: Text("Record-Stop"),
          ),
        ],
      ),
    );
  }
}
