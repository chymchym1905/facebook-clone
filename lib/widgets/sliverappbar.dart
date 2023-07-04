// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:sliver_tools/sliver_tools.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import '../index.dart';

const a = MySliverAppBar();
final b = AppBar(key: const ValueKey('2'), toolbarHeight: 0, elevation: 0);

class AppBarManager with ChangeNotifier {
  Widget _currentAppBar = a;

  Widget get currentAppBar => _currentAppBar;

  dynamic toggleAppBar(isTab0) {
    _currentAppBar = isTab0 ? a : b;
    notifyListeners();
  }
}

class MySliverAppBar extends StatefulWidget {
  const MySliverAppBar({
    Key? key,
  }) : super(key: key);
  @override
  State<MySliverAppBar> createState() => _MySliverAppBarState();
}

class _MySliverAppBarState extends State<MySliverAppBar> {
  // late AnimationController _animationController;
  // late bool _value;

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 300),
  //   );
  //   _value = true;
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  // void _updateValue(bool newValue) {
  //   setState(() {
  //     _value = widget.tab.index == 0 ? true : false;
  //   });

  //   _animationController
  //     ..reset()
  //     ..forward();
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: const ValueKey('1'),
      elevation: 0,
      // expandedHeight: -MediaQuery.of(context).size.height,
      actions: [
        Switch(
            value: themeManager.themeMode == dark,
            onChanged: (value) => themeManager.toggleTheme(value),
            activeColor: white),
        IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            onPressed: () {},
            icon: const Icon(Icons.add)),
        IconButton(
            splashRadius: MediaQuery.of(context).size.width * 0.07,
            onPressed: () {},
            icon: const Icon(Icons.search)),
      ],
      // expandedHeight: statusBarHeight,
      title: Text(
        'fakebook',
        style: TextStyle(
          fontSize: 29,
          fontFamily: 'Calibri',
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          color: themeManager.themeMode == dark ? white : Palette.facebookBlue,
        ),
      ),
      // bottom: primaryTabBar,
    );
  }
}

// class SlivAnimatedSwitcher extends StatelessWidget {
//   final Widget child;
//   final Duration duration;

//   const SlivAnimatedSwitcher({
//     Key? key,
//     required this.child,
//     required this.duration,
//   }) : super(key: key);

//   static Widget defaultLayoutBuilder(
//       Widget? currentChild, List<Widget> previousChildren) {
//     return SliverStack(
//       children: <Widget>[
//         ...previousChildren,
//         if (currentChild != null) currentChild,
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // RenderBox? box = context.findRenderObject() as RenderBox?;
//     // Offset? position = box?.localToGlobal(Offset.zero);
//     return AnimatedSwitcher(
//       duration: duration,
//       layoutBuilder: defaultLayoutBuilder,
//       transitionBuilder: (Widget child, Animation<double> animation) {
//         return Positioned(
//             top: 0,
//             child: SlideTransition(
//                 position: Tween<Offset>(
//               begin: const Offset(0, 0),
//               end: const Offset(0, -20),
//             ).animate(animation)));
//       },
//       child: child,
//     );
//   }
// }

class AppBarTransition extends StatelessWidget {
  final Widget childWidget;
  final Animation<double> animation;
  const AppBarTransition({
    Key? key,
    required this.childWidget,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SizedBox(
          height: kToolbarHeight * 2,
          child: Stack(
              alignment: Alignment.topCenter,
              children: [Positioned(top: animation.value, child: childWidget)]),
        );
      },
    );
  }
}
