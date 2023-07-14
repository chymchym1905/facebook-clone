import '../index.dart';
// import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initialize();
  runApp(AppDataProvider(
      AppData(
          commentPostPage: FocusNode(),
          commentModal: FocusNode(),
          notificationCount: 0),
      child: const FakeBook()));
}

ThemeProvider themeManager = ThemeProvider();

class FakeBook extends StatefulWidget {
  const FakeBook({super.key});

  @override
  State<FakeBook> createState() => _FakeBookState();
}

class _FakeBookState extends State<FakeBook> {
  @override
  void initState() {
    super.initState();
    themeManager.addListener(themeListener);
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeManager.themeMode,
      // navigatorKey: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            } else {
              return const LoginRegister();
            }
          }),
    );
  }
}
