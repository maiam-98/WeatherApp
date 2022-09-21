import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MenuItemit{
  final String title;
  final IconData icon;

  const MenuItemit(this.title, this.icon);
}
class MenuItems {
  static const mainScreen = MenuItemit('Main Screen', Icons.home);
  static const aboutApp = MenuItemit('About the App', Icons.app_blocking);
  static const aboutUs = MenuItemit('About us', Icons.star);
  static const report = MenuItemit('Report a problem', Icons.report);

  static const all = <MenuItemit>[
    mainScreen,
    aboutApp,
    aboutUs,
    report,
  ];
}

class MenuPage extends StatelessWidget {
  final MenuItemit currentItem;
  final ValueChanged<MenuItemit> onSelectedItem;
  const  MenuPage({Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(37, 109, 133, 1),
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                ...MenuItems.all.map(buildMenuItem).toList(),
                const Spacer(flex: 2,),
              ],
            )
        ),
      ),
    );

  Widget buildMenuItem(MenuItemit item) => ListTileTheme(
    selectedColor: Colors.white,
    child: ListTile(
      selectedColor: Colors.black26 ,
      selected: currentItem == item,
      minLeadingWidth: 20,
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => onSelectedItem(item),
    ),
  );
}


