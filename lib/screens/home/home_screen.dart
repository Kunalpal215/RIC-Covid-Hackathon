// // Importing packages
// import 'package:flutter/cupertino.dart';
import 'package:covid_app/screens/covid_map/map.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/screens/auth/profile_screen.dart';
// import 'package:covid_app/services/share_app.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // Importing Screens
// import 'package:covid_app/screens/welcome_screen.dart';
// import 'package:covid_app/screens/auth/profile_screen.dart';
// import 'package:covid_app/constants.dart';
// import 'package:covid_app/screens/home/contactpage.dart';

// // Importing Services
// import 'package:covid_app/services/logout_user.dart';
// import 'package:covid_app/services/permissions.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
        ],
        title: const Text(
          'Home Screen',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, MapScreen.id);
              },
              child: Text('Covid Map'),
            ),
          ],
        ),
      ),
    );
    // return const Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.person,
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, ProfileScreen.id);
//             },
//           ),
//         ],
//         title: const Text(
//           'Home Screen',
//         ),
//       ),
//       //DRAWER
//       drawer: SafeArea(
//         child: Drawer(
//           child: ListView(
//             children: [
//               UserAccountsDrawerHeader(
//                 accountName: Text(auth.currentUser!.phoneNumber!),
//                 accountEmail: const Text('abcd@abcd.com'),
//               ),
//               InkWell(
//                 child: ListTile(
//                   leading: const Icon(Icons.info),
//                   title: const Text("About us"),
//                   onTap: () {},
//                 ),
//               ),
//               InkWell(
//                 child: ListTile(
//                   leading: const Icon(
//                     Icons.exit_to_app,
//                   ),
//                   title: const Text("Log Out"),
//                   onTap: () async {
//                     await logoutUser();
//                     Navigator.pushNamed(context, WelcomeScreen.id);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SizedBox.expand(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 final PermissionStatus permissionStatus =
//                     await getContactPermission();
//                 if (permissionStatus == PermissionStatus.granted) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ContactPage()));
//                 } else {
//                   //If permissions have been denied show standard cupertino alert dialog
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) => CupertinoAlertDialog(
//                       title: const Text('Permissions error'),
//                       content: const Text('Please enable contacts access '
//                           'permission in system settings'),
//                       actions: <Widget>[
//                         CupertinoDialogAction(
//                           child: const Text('OK'),
//                           onPressed: () => Navigator.of(context).pop(),
//                         )
//                       ],
//                     ),
//                   );
//                 }
//               },
//               child: const Text('Import Contacts'),
//             ),
//             ElevatedButton(
//               child: const Text(
//                 'Invite a Friend',
//               ),
//               onPressed: () async {
//                 await shareApp(context);
//               },
//             )
//           ],
//         ),
        // ),
        // );
  }
}
