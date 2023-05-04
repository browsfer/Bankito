import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class MyIntroSlider extends StatefulWidget {
  const MyIntroSlider({super.key});

  @override
  State<MyIntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<MyIntroSlider> {
  List<Widget> customTabs = [];

  @override
  void initState() {
    super.initState();
    customTabs.add(SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/bankito_logo.png',
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/splash_photo.png',
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Better way to manage your wallet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We compare offers from the largest national banks and other licensed lenders to customize funding for any need.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
    customTabs.add(SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/bankito_logo.png',
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/splash_photo.png',
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Better way to manage your wallet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We compare offers from the largest national banks and other licensed lenders to customize funding for any need.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
    customTabs.add(SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/bankito_logo.png',
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/splash_photo.png',
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Better way to manage your wallet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We compare offers from the largest national banks and other licensed lenders to customize funding for any need.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listCustomTabs: customTabs,
      isShowDoneBtn: false,
      isShowNextBtn: false,
      isShowSkipBtn: false,
      isShowPrevBtn: false,
      autoScrollInterval: const Duration(seconds: 4),
      isLoopAutoScroll: true,
      isScrollable: true,
      isAutoScroll: true,
      indicatorConfig: const IndicatorConfig(
        colorIndicator: Colors.grey,
        colorActiveIndicator: Colors.white,
      ),
    );
  }
}
