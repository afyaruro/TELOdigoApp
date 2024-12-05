import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telodigo/data/controllers/controllerDisable.dart';
import 'package:telodigo/data/controllers/mapcontroller.dart';
import 'package:telodigo/data/controllers/negociocontroller.dart';
import 'package:telodigo/data/controllers/usercontroller.dart';
import 'package:telodigo/firebase_options.dart';
import 'package:telodigo/ui/components/customcomponents/custombackgroundlogin.dart';
import 'package:telodigo/ui/pages/inicio/init_page.dart';

void main() {
  runApp(const MyAppWithSplash());
}
 
class MyAppWithSplash extends StatelessWidget {
  const MyAppWithSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: "TELOdigo",
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 5, milliseconds: 22), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Init_Page()),
      );
    });
  }

  Future<void> _initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseFirestore.instance.clearPersistence();
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: false);

    Get.put(UserController());
    Get.put(NegocioController());
    Get.put(MapController());
    Get.put(DisableController());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundLogin(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: 250,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _controller.value * 5 >= index &&
                                _controller.value * 5 < index + 1
                            ? Colors.white
                            : Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
