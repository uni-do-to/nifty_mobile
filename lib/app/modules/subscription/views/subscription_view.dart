import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/subscription/controllers/subscription_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/size_utils.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            Text(
              LocaleKeys.subscription_view_title.tr,
              style: theme?.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: Container()),
            Neumorphic(
              padding: EdgeInsets.all(35.toWidth),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.toHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '3',
                        style: theme?.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 100.toFont,
                          height: 0.4,
                        ),
                      ),
                      Text(
                        LocaleKeys.euro_mark.tr,
                        style: theme?.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 100.toFont,
                          height: 0.4,
                        ),
                      ),
                      SizedBox(
                        width: 50.toWidth,
                      ),
                      Text(
                        LocaleKeys.subscription_per_year.tr,
                        style: theme?.textTheme.bodyMedium,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  SizedBox(height: 100.toHeight),
                  Divider(
                    color: ColorConstants.lightGray,
                    height: 0.5,
                    thickness: 0.5,
                  ),
                  SizedBox(height: 60.toHeight),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornar.',
                        textAlign: TextAlign.start,
                        style: theme?.textTheme.bodySmall,
                      ),
                      SizedBox(
                        height: 40.toHeight,
                      ),
                      ...List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                'Detail ${index + 1}',
                                style: theme?.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10.toWidth,
                              ),
                              Text(
                                'Lorem ipsum dolor sit amet',
                                style: theme?.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  NeumorphicButton(
                    onPressed: () {
                      // Handle your button press
                    },
                    child: Container(
                      width: 300.toWidth,
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            color: theme?.accentColor,
                            size: 13,
                          ),
                          SizedBox(
                            width: 20.toWidth,
                          ),
                          Text(
                            LocaleKeys.subscription_button_label.tr,
                            style: theme?.textTheme.bodySmall?.copyWith(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
