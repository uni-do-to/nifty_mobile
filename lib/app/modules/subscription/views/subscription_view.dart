import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import 'package:nifty_mobile/app/modules/subscription/controllers/subscription_controller.dart';

import '../../../../generated/locales.g.dart';
import '../../../utils/size_utils.dart';
import '../../profile/views/profile_view.dart';
import '../../register/views/register_views_title.dart';

class SubscriptionView extends GetView<SubscriptionController> {

  final GlobalKey webViewKey = GlobalKey();


  SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 36,) ,
            RegisterViewsTitle(text: LocaleKeys.subscription_view_title.tr),

            Expanded(child: Container()),
            Container(
              child: Obx( () {
                if(controller.loading.value){
                  return Center(child: CircularProgressIndicator()) ;
                }else if(controller.checkoutSuccess.value) {
                  return  Neumorphic(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Success",
                              style: theme?.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 48,
                                height: 0.4,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24),
                        Divider(
                          color: ColorConstants.lightGray,
                          height: 0.5,
                          thickness: 0.5,
                        ),
                        SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Checkout success" ,
                              textAlign: TextAlign.center,
                              style: theme?.textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Please wait while setting up the app for you",
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              style: theme?.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 32,),
                        CircularProgressIndicator()
                      ],
                    ),
                  );
                }
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 420,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.9
                    ),
                    items: controller.plans.map((plan) {
                      return Container(
                        padding: EdgeInsets.all(4),
                        child: Neumorphic(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    plan.price?.toStringAsFixed(2)??"",
                                    style: theme?.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 48,
                                      height: 0.4,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.simpleCurrency(name: plan.currency?.toUpperCase()).currencySymbol,
                                    style: theme?.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 48,
                                      height: 0.4,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "/${plan.interval?.tr}",
                                    style: theme?.textTheme.titleMedium?.copyWith(
                                      height: 0.4
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Visibility(
                                  visible: plan.trialPeriodDays!=null && plan.trialPeriodDays! > 0,
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  child: Text(
                                    "${plan.trialPeriodDays} Days free trial",
                                    style: theme?.textTheme.titleSmall,
                                    textAlign: TextAlign.end,
                                  )),
                              SizedBox(height: 8),
                              Divider(
                                color: ColorConstants.lightGray,
                                height: 0.5,
                                thickness: 0.5,
                              ),
                              SizedBox(height: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    plan.title??"" ,
                                    textAlign: TextAlign.center,
                                    style: theme?.textTheme.titleLarge,
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                Text(
                                  plan.description ?? "",
                                  textAlign: TextAlign.center,
                                  maxLines: 5,
                                  style: theme?.textTheme.titleMedium,
                                ),
                              ],
                              ),
                              Expanded(child: Container()),
                              NeumorphicButton(
                                onPressed: () {
                                  // Handle your button press
                                  controller.redirectToSubscription(plan.id!) ;
                                },
                                child: Container(
                                  // width: 300.toWidth,
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
                      ) ;
                    }
                    ).toList(),
                  );
                }
              ),
            ),
            Expanded(child: Container()),
            Neumorphic(
              child: Column(
                children: [
                  SettingsTile(
                    title: LocaleKeys.logout_label.tr,
                    icon: Icon(Icons.logout),
                    onTap: () async {
                      var result = await Get.dialog(AlertDialog(
                        title: Text(
                          LocaleKeys.logout_label.tr,
                          style: theme?.textTheme.titleLarge,
                        ),
                        content: Text(LocaleKeys.logout_confirm_question.tr),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              LocaleKeys.cancel_label.tr,
                              style: theme?.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Get.back(result: false);
                            },
                          ),
                          TextButton(
                            child: Text(LocaleKeys.logout_label.tr,
                                style: theme?.textTheme.titleMedium),
                            onPressed: () {
                              Get.back(result: true);
                            },
                          ),
                        ],
                      ));
                      if (result == true) {
                        controller.logout();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
