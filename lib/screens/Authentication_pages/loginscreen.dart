import '../../index.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister>
    with WidgetsBindingObserver {
  final TextEditingController emailString = TextEditingController();
  final TextEditingController passwordString = TextEditingController();
  bool isLogin = true;
  String errorMessage = '';

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailandPassword(
          email: emailString.text, password: passwordString.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? errorMessage;
        print(e.message);
        showError();
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailandPassword(
          email: emailString.text, password: passwordString.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? errorMessage;
        print(e.message);
        showError();
      });
    }
  }

  showError() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errorMessage == '' ? "Unknown Error" : errorMessage),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    if (value == 0 && MediaQuery.of(context).viewInsets.bottom != 0) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonheight = MediaQuery.of(context).size.width * 0.15;
    double buttonwidth = MediaQuery.of(context).size.width * 0.9;
    final Brightness systemBrightness =
        MediaQuery.of(context).platformBrightness;
    final Widget lightBackground =
        Container(color: const Color.fromARGB(187, 255, 255, 255));
    final Widget darkBackground =
        Container(color: const Color.fromARGB(213, 0, 0, 0));
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                Color(0xff1f005c),
                Color(0xff5b0060),
                Color(0xff870160),
                Color(0xffac255e),
                Color(0xffca485c),
                Color(0xffe16b5c),
                Color(0xfff39060),
                Color(0xffffb56b),
              ],
                  tileMode: TileMode.mirror,
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  // stops: [0.8, 1],
                  transform: GradientRotation(0.5))),
        ),
        systemBrightness == Brightness.dark ? darkBackground : lightBackground,
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            //email field
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onTap: () {
                emailString.selection = TextSelection(
                    baseOffset: 0, extentOffset: emailString.value.text.length);
              },
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: emailString,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 80, 75, 75)),
                labelText: "Email",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 75, 75))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 75, 75))),
              ),
            ),
          ),
          Padding(
            //password field
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: '●',
              // style: TextStyle(letterSpacing: 2),
              controller: passwordString,
              onTap: () {
                passwordString.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: passwordString.value.text.length);
              },
              decoration: InputDecoration(
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 107, 103, 103)),
                labelText: "Password",
                filled: true,
                fillColor: Colors.transparent,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 75, 75))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 80, 75, 75))),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                isLogin
                    ? signInWithEmailAndPassword()
                    : createUserWithEmailAndPassword();
              },
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.transparent,
              highlightColor: const Color.fromARGB(88, 191, 184, 184),
              child: Ink(
                height: buttonheight,
                width: buttonwidth,
                decoration: BoxDecoration(
                    color: Palette.facebookBlue,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Center(
                      child: isLogin
                          ? const Text('Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)))
                          : const Text('Register',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255))),
                    )),
              ),
            ),
          ),
          TextButton(
            onPressed: () => setState(() {
              Navigator.of(context)
                  .pushNamed('/forgotpassword', arguments: emailString.text);
            }),
            child: const Text('Forgot Password',
                style: TextStyle(color: Color.fromARGB(255, 107, 103, 103))),
          )
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() {
                  isLogin = !isLogin;
                }),
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.transparent,
                highlightColor: const Color.fromARGB(88, 191, 184, 184),
                child: Ink(
                    height: buttonheight,
                    width: buttonwidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Palette.facebookBlue),
                        color: const Color.fromARGB(0, 101, 96, 96),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 30, right: 30),
                      child: Center(
                        child: isLogin
                            ? const Text(
                                'Create an account',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 107, 103, 103)),
                              )
                            : const Text('Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 107, 103, 103))),
                      ),
                    )),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
