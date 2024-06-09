import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kidzo_app/Screens/Parent/parent_page1.dart';
import 'package:kidzo_app/Screens/login/imports.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.isParent = true});

  final bool isParent;

  @override
  State<NavBarPage> createState() => _NavbArPageState();
}

class _NavbArPageState extends State<NavBarPage> {
  int pageIndex = 0;
  var parentPage = [
    const ParentCodePage(),
     HomePage(),
  ];
  var childPage = [const ChildHomePage()];
  final GlobalKey<CurvedNavigationBarState> _navKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _navKey,
        backgroundColor: Colors.white,
        color: appColor,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          /*Icon(
            Icons.person,
            color: Colors.white,
          ),*/
          /*
          Icon(
            Icons.person,
            color: Colors.white,
          ), */
        ],
      ),
      body: widget.isParent ? parentPage[pageIndex] : childPage[pageIndex],
    );
  }
}