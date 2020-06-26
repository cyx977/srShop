import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/products_grid.dart';

void contactSearch({String query}) async {
  if (await Permission.contacts.request().isGranted) {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(query: query);
    print("Searching for \"$query\"");
    contacts.toList().forEach((element) {
      var numbers = element.phones.map((e) => e.value).toList();
      print("${element.displayName}: ${numbers[0]}");
    });
  }
}

//push notifications
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
}

class ProductsOverviewScreen extends StatefulWidget {
  static const route = "/";

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

enum FilterOptions {
  All,
  Favourite,
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool popupSelection = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Casual"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.All) {
                  popupSelection = true;
                } else {
                  popupSelection = false;
                }
              });
            },
            enabled: true,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text("Show Favourites"),
                value: FilterOptions.Favourite,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.60,
            child: ProductsGrid(
              popupSelection: popupSelection,
            ),
          ),
          RaisedButton(
            onPressed: () {
              contactSearch(query: "r");
            },
            child: Text("Contact Search"),
          ),
          RaisedButton(
            onPressed: writeTest,
            child: Text("Notification"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Record-Start"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Record-Stop"),
          ),
        ],
      ),
    );
  }
}
