import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'core/utils/strings.dart';
import 'features/onboarding/presentation/onboarding.dart';
import 'core/theme/theme.dart';
import 'injection_container.dart' as di;
import 'dart:math' as math;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize dependency injection
  await di.init();
  runApp(ProviderScope(child: MovieColony()));
}

//create themeProvider
final themeProvider = StateNotifierProvider<CustomTheme, ThemeData>((ref) {
  return di.sl<CustomTheme>();
});

class MovieColony extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieColony',
        theme: theme,
        home: SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _dotKey = GlobalKey();
  Offset? dotCenter;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(seconds: 2),
    )..addListener(() {
        if (mounted) setState(() {});
      });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      dotCenter =
          getCenterPositionForDot(); // Could be added to the listener instead
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    double radius = math.sqrt((math.pow(height, 2.0) + math.pow(width, 2.0)) /
        4); // Pythagoras theorem
    final screenCenter = Offset(width / 2, height / 2);
    dotCenter ??= screenCenter;
    final center = Offset(
      screenCenter.dx + (dotCenter!.dx - screenCenter.dx) * controller.value,
      screenCenter.dy + (dotCenter!.dy - screenCenter.dy) * controller.value,
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            color: Colors.green,
            child: TextWidget(dotKey: _dotKey),
          ),
          ClipOval(
            clipper: MyClipper(
                center: center, radius: radius * (1 - controller.value).abs()),
            child: Container(
              color: Colors.blue,
              height: height,
              width: width,
              alignment: Alignment.center,
              child: TextWidget(color: Colors.green),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: TextButton(
              child: Text("Reset"),
              onPressed: () {
                controller.reset();
                controller.forward();
              },
            ),
          ),
        ],
      ),
    );
  }

  getCenterPositionForDot() {
    final renderBox = _dotKey.currentContext?.findRenderObject() as RenderBox;
    final topLeft = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final center =
        topLeft + Offset(size.width / 2, size.height / 2 - 6 /* Margin */);
    return center;
  }
}

class TextWidget extends StatelessWidget {
  final Color color;
  final Key? dotKey;

  const TextWidget({Key? key, this.color: Colors.white, this.dotKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double dotSize = 10;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Btooom",
            style: TextStyle(
                color: this.color,
                fontSize: 56,
                height: 1,
                fontWeight: FontWeight.w700)),
        Container(
          key: dotKey,
          height: dotSize,
          width: dotSize,
          // To bring the Dot to the baseline of the text
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: this.color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final Offset center;
  final double radius;

  const MyClipper({required this.center, required this.radius});
  Rect getClip(Size size) {
    return Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );
  }

  bool shouldReclip(MyClipper old) =>
      old.radius != this.radius || old.center != this.center;
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MovieColony')),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              context
                  .read(themeProvider.notifier)
                  .changeTheme(CustomTheme.darkThemeData, DARK_THEME);
            },
            child: Text(
              'Hello World',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          TextButton(
            onPressed: () {
              context
                  .read(themeProvider.notifier)
                  .changeTheme(CustomTheme.lightThemeData, LIGHT_THEME);
            },
            child: Text(
              'Hello Africa',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
