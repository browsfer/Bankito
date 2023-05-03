import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class MyIntroSlider extends StatefulWidget {
  const MyIntroSlider({super.key});

  @override
  State<MyIntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<MyIntroSlider> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();
    listContentConfig.add(
      ContentConfig(
        marginTitle: EdgeInsets.zero,
        widgetTitle: Image.asset(
          'assets/images/bankito_logo.png',
          fit: BoxFit.scaleDown,
        ),
        centerWidget: Image.asset(
          'assets/images/example_photo.png',
        ),
      ),
    );

    listContentConfig.add(
      ContentConfig(
          widgetTitle: Image.asset('assets/images/bankito_logo.png'),
          description:
              "Allow miles wound place the leave had. To sitting subject no improve studied limited",
          foregroundImageFit: BoxFit.scaleDown),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      isShowDoneBtn: false,
      isShowNextBtn: false,
      isShowSkipBtn: false,
      isShowPrevBtn: false,
      indicatorConfig: const IndicatorConfig(
        colorIndicator: Colors.grey,
        colorActiveIndicator: Colors.white,
      ),
    );
  }
}
