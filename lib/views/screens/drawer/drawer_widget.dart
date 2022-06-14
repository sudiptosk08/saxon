import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/constants/shared_preference_constant.dart';
import 'package:saxonmarket/controller/auth/user_controller.dart';
import 'package:saxonmarket/controller/products/products_by_keyword_controller.dart';
import 'package:saxonmarket/views/screens/auth/login_screen.dart';
import 'package:saxonmarket/views/screens/categories/categories_screen.dart';
import 'package:saxonmarket/views/screens/my_account/my_account_screen.dart';
import 'package:saxonmarket/views/screens/products/products_list_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetLogInState createState() => _DrawerWidgetLogInState();
}

int selectedIndex = -1;

class _DrawerWidgetLogInState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    const name = "Sudipto";
    const mail = "sudiptosarker05@gmail.cm";
    const urlImage = AssetPath.profile;

    return Drawer(
      child: Material(
        color: KColor.white,
        child: ListView(
          children: <Widget>[
            buildHeader(
              name: name,
              email: mail,
              urlImage: urlImage,
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Home',
                    icon: Icons.home,
                    index: 0,
                    onClicked: () {
                      selectedItem(context, 0);
                    },
                    dividerColor: KColor.white,
                    tColor: KColor.drawerItem,
                    iconColor: KColor.drawerItem,
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      return buildMenuItem(
                        text: 'New Collection',
                        icon: Icons.flag,
                        index: 1,
                        onClicked: () {
                          ref.read(productsByKeywordProvider.notifier).fetchNewArrivalProducts();
                          selectedItem(context, 1);
                        },
                        dividerColor: KColor.white,
                        tColor: KColor.drawerItem,
                        iconColor: KColor.drawerItem,
                      );
                    },
                  ),
                  buildMenuItem(
                    text: 'Categories',
                    icon: Icons.category,
                    index: 2,
                    onClicked: () {
                      selectedItem(context, 2);
                    },
                    dividerColor: KColor.white,
                    tColor: KColor.drawerItem,
                    iconColor: KColor.drawerItem,
                  ),
                  buildMenuItem(
                    text: 'Notification',
                    icon: Icons.notification_add,
                    index: 3,
                    onClicked: () {
                      selectedItem(context, 3);
                    },
                    dividerColor: KColor.white,
                    tColor: KColor.drawerItem,
                    iconColor: KColor.drawerItem,
                  ),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    index: 4,
                    onClicked: () {
                      selectedItem(context, 4);
                    },
                    dividerColor: KColor.white,
                    tColor: KColor.drawerItem,
                    iconColor: KColor.drawerItem,
                  ),
                  buildMenuItem(
                    text: 'Help',
                    icon: Icons.help,
                    index: 5,
                    onClicked: () {
                      selectedItem(context, 5);
                    },
                    dividerColor: KColor.white,
                    tColor: KColor.drawerItem,
                    iconColor: KColor.drawerItem,
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      return ref.read(userProvider.notifier).userData == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(left: 9.0, top: 15),
                              child: drawerLogout(
                                text: "Logout",
                                icon: Icons.logout,
                                onClicked: () {
                                  setValue(LOGGED_IN, false);
                                  ref.read(userProvider.notifier).resetUserData();
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
                                },
                              ),
                            );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({required String urlImage, required String name, required String email}) {
    return Consumer(
      builder: (context, ref, _) {
        final userData = ref.watch(userProvider.notifier).userData;

        return InkWell(
          onTap: () {
            if (userData != null) Navigator.push(context, CupertinoPageRoute<void>(builder: (BuildContext context) => const MyAccountScreen()));
          },
          child: Container(
            color: KColor.drawerBackgroundLite,
            padding: const EdgeInsets.only(left: 27, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(onPressed: () => Navigator.pop(context), icon: const FaIcon(FontAwesomeIcons.times)),
                ),
                Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(urlImage)),
                      color: KColor.primary,
                      borderRadius: BorderRadius.circular(45),
                    )),
                const SizedBox(height: 15),
                Text(userData == null ? 'Hello,' : userData.name!, style: KTextStyle.headline6),
                const SizedBox(height: 4),
                InkWell(
                    onTap: () {
                      if (userData == null) Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: Text(userData == null ? 'Sign In' : userData.email!, style: KTextStyle.bodyText2.copyWith(color: KColor.accentColor))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget drawerLogout({required String text, required IconData icon, required VoidCallback onClicked}) {
    final hoverColor = KColor.white60;

    return ListTile(
      minVerticalPadding: 0,
      minLeadingWidth: 2,
      title: Row(
        children: [
          Icon(icon, size: 22, color: KColor.primary),
          const SizedBox(width: 15),
          Text(text, style: KTextStyle.drawer.copyWith(color: KColor.primary)),
        ],
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required int index,
    required VoidCallback onClicked,
    required Color dividerColor,
    required Color tColor,
    required Color iconColor,
  }) {
    final hoverColor = KColor.white60;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      leading: VerticalDivider(color: selectedIndex == index ? KColor.primary : dividerColor, thickness: 7, indent: 2, endIndent: 2, width: 5),
      minVerticalPadding: 0,
      minLeadingWidth: 2,
      title: Row(
        children: [
          Icon(icon, size: 22, color: selectedIndex == index ? KColor.primary : iconColor),
          const SizedBox(width: 15),
          Text(text, style: KTextStyle.drawer.copyWith(color: selectedIndex == index ? KColor.primary : tColor)),
        ],
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => const ProductsListScreen(title: 'New Collection'),
        ));
        break;

      case 2:
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) =>  CategoriesScreen(index: 0,),
        ));
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
    }

    if (!mounted) return;
    setState(() {
      selectedIndex = 0;
    });
  }
}
