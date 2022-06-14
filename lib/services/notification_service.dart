// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:scorebee/controller/auth/auth_controller.dart';
// import 'package:scorebee/controller/club/club_controller.dart';
// import 'package:scorebee/controller/tournament/single_tournament_details_controller.dart';
// import 'package:scorebee/controller/tournament/tournament_matches_list_controller.dart';
// import 'package:scorebee/services/navigation_service.dart';
// import 'package:scorebee/views/screens/club/club_screen.dart';
// import 'package:scorebee/views/screens/player_profile/pending_request_screen.dart';
// import 'package:scorebee/views/screens/scoring/match_details/match_details_screen.dart';
// import 'package:scorebee/views/screens/search/components/search_card.dart';
// import 'package:scorebee/views/screens/team/my_team_screen.dart';
// import 'package:scorebee/views/screens/tournaments/tournament_tab_details_screen.dart';

// FirebaseMessaging messaging = FirebaseMessaging.instance;

// class NotificationService {
//   static final NotificationService? _notificationService = NotificationService._internal();

//   factory NotificationService() {
//     return _notificationService!;
//   }

//   NotificationService._internal();

//   NotificationSettings? settings;

//   firebaseInitialization() async {
//     await Firebase.initializeApp();
//     checkPermissionStatus();
//   }

//   checkPermissionStatus() async {
//     settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     print('Permission status: ${settings!.authorizationStatus}');
//     if (settings!.authorizationStatus == AuthorizationStatus.authorized) {
//       print('Authorized, initializing listeners');

//       /// For iOS Foreground notification
//       messaging.setForegroundNotificationPresentationOptions(
//         badge: true,
//         alert: true,
//         sound: true,
//       );

//       /// Background
//       FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//       init();
//       getToken();
//     }
//   }

//   static Future getToken() async {
//     String fcmToken = await messaging.getToken() ?? 'No FCM Token';
//     print('fcmToken = $fcmToken');
//     return fcmToken;
//   }

//   Future<void> init() async {
//     /// Foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         print(
//             'Foreground (onMessage): Title:${message.notification!.title}, Subtitle:${message.notification!.body}, Data:${message.data.toString()}');
//         NavigationService.navigatorKey.currentState!.context.read(authProvider.notifier).incrementNotificationCounter();
//       }
//     });

//     /// Background but not terminated
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       if (message.notification != null) {
//         print('onMessageOpenedApp: Title:${message.notification!.title}, Subtitle:${message.notification!.body}, Data:${message.data.toString()}');
//         var data = json.decode(message.data['metadata']);

//         /// Deep-linking
//         if (data['type'] == 'team_remove_player') {
//           // not needed
//         } else if (data['type'] == 'team_added_player') {
//           initFilter = "TEAM";
//           NavigationService.navigatorKey.currentState!.context.read(clubProvider.notifier).fetchClubDetails(data['team_id'], 'TEAM');
//           searchTeamId = data['team_id'];
//           teamId = data['team_id'];
//           await NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => ClubScreen(true, data['club_id'], "Team", "")));
//         } else if (data['type'] == 'player_to_club_join_request') {
//           NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => MyTeamScreen(route: 'club')));
//         } else if (data['type'] == 'player_to_club_join_cancel') {
//           // not needed
//         } else if (data['type'] == 'player_to_club_join_accept') {
//           NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => MyTeamScreen()));
//         } else if (data['type'] == 'man_of_the_match') {
//           NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => MatchDetailsScreen(data['fixture_id'], '', '', '', '')));
//         } else if (data['type'] == 'club_to_player_join_request') {
//           NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => PendingRequestScreen()));
//         } else if (data['type'] == 'club_to_player_join_accept') {
//           initFilter = "CLUB";
//           NavigationService.navigatorKey.currentState!.context.read(clubProvider.notifier).fetchClubDetails(data['club_id'], 'CLUB');
//           NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => ClubScreen(false, data['club_id'], "Club", "")));
//         } else if (data['type'] == 'club_to_player_join_cancel') {
//           // not needed
//         } else if (data['type'] == 'tournament_to_club_invitation_request') {
//           NavigationService.navigatorKey.currentState!.context
//               .read(singleTournamentDetailsProvider)
//               .getSingleTournamentDetails(data['tournament_id']);
//           NavigationService.navigatorKey.currentState!.context.read(tournamentMatchesListProvider.notifier).getTournamentMatches(data['tournament_id']);

//           NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => TournamentTabDetailsScreen()));
//         }
//       }
//     });

//     /// Background and terminated
//     //fetchInitialMessages();
//   }

//   /// Background and terminated
//   fetchInitialMessages() {
//     messaging.getInitialMessage().then((message) {
//       if (message != null) {
//         print(
//             'Background (Terminated): Title:${message.notification!.title}, Subtitle:${message.notification!.body}, Data:${message.data.toString()}');

//         // NavigationService.navigatorKey.currentState.context
//         //     .read(notificationListProvider)
//         //     .fetchNotifications()
//         //     .then((value) => NavigationService.navigatorKey.currentState.NavigationService.navigatorKey.currentState.context.read(notificationListProvider.notifier).markAllNotificationSeen());
//         // NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => NotificationScreen()));
//       } else {
//         // NavigationService.navigateTo(CupertinoPageRoute(builder: (_) => KBottomNavigationBar()));
//       }
//     });
//   }
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print(
//       'firebaseMessagingBackgroundHandler: Title:${message.notification!.title}, Subtitle:${message.notification!.body}, Data:${message.data.toString()}');
// }
