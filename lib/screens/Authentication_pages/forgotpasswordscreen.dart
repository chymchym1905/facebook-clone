import '../../index.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.email});
  final String email;
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with WidgetsBindingObserver {
  final TextEditingController emailString = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailString.text = widget.email;
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

  Future<void> sendPasswordResetEmail() async {
    Auth().resetPassword(emailString.text.trim());
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Info'),
            content: Text('Password reset mail sent to ${emailString.text}'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness systemBrightness =
        MediaQuery.of(context).platformBrightness;
    final Widget lightBackground =
        Container(color: const Color.fromARGB(187, 255, 255, 255));
    final Widget darkBackground =
        Container(color: const Color.fromARGB(213, 0, 0, 0));
    double buttonheight = MediaQuery.of(context).size.width * 0.15;
    double buttonwidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      body: Stack(
        children: [
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
          systemBrightness == Brightness.dark
              ? darkBackground
              : lightBackground,
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              //email field
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onTap: () {
                  emailString.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: emailString.value.text.length);
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
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  sendPasswordResetEmail();
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
                  child: const Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Center(
                          child: Text('Send password reset email',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255))))),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
