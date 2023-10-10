import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<String> savedNotifications = [];

  @override
  void initState() {
    super.initState();
    // Fetch saved notifications from local storage
    fetchSavedNotifications();
  }

  Future<void> fetchSavedNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String notificationData = prefs.getString('notificationData') ?? '';

    // Split the stored data and add it to the list
    setState(() {
      savedNotifications = notificationData.isNotEmpty
          ? notificationData.split(',')
          : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          if (savedNotifications.isNotEmpty)
            // Display saved notifications if there are any
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: savedNotifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(savedNotifications[index]),
                    // You can customize how each notification is displayed here
                  );
                },
              ),
            )
          else
            // If there are no saved notifications, show a message
            Center(
              child: Text(
                "No saved notifications yet!",
                style: GoogleFonts.ubuntu(
                  textStyle: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
