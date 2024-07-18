import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:nifty_mobile/app/config/color_constants.dart';
import '../../../../generated/locales.g.dart';
import '../../../utils/size_utils.dart';
import '../../profile/views/profile_view.dart';
import '../../register/views/register_views_title.dart';
import '../controllers/apple_subscription_controller.dart';

class SingleSubscriptionView extends GetView<AppleSubscriptionController> {

  SingleSubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = NeumorphicTheme.of(context)?.current;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 36,),
            RegisterViewsTitle(text: LocaleKeys.subscription_view_title.tr),
            Expanded(child: Container()),
            Container(
              child: Obx(() {
                if(controller.loading.value){
                  return Center(child: CircularProgressIndicator());
                } else if(controller.checkoutSuccess.value) {
                  return Neumorphic(
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
                              "Checkout success",
                              textAlign: TextAlign.center,
                              style: theme?.textTheme.titleLarge,
                            ),
                            SizedBox(height: 24),
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

                if (controller.loadProductError.value) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Failed to load product",
                          style: theme?.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 16),
                        NeumorphicButton(
                          onPressed: controller.loadProductDetails,
                          child: Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                final productDetails = controller.productDetails.value;
                if (productDetails == null) {
                  return Center(child: CircularProgressIndicator());
                }

                return Neumorphic(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    height: 420,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              productDetails.price,
                              style: theme?.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                fontSize: 48,
                                height: 0.4,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "/lifetime",
                              style: theme?.textTheme.titleMedium?.copyWith(
                                  height: 0.4
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
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
                              productDetails.title,
                              textAlign: TextAlign.center,
                              style: theme?.textTheme.titleLarge,
                            ),
                            SizedBox(height: 24),
                            Text(
                              productDetails.description,
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              style: theme?.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        NeumorphicButton(
                          onPressed: () {
                            controller.purchaseLifetimeMembership();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: theme?.accentColor,
                                  size: 13,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  LocaleKeys.subscription_button_label.tr,
                                  style: theme?.textTheme.bodySmall?.copyWith(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      NeumorphicButton(
                        onPressed: () {
                          controller.restorePurchases();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restore,
                                color: theme?.accentColor,
                                size: 13,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Restore purchase",
                                style: theme?.textTheme.bodySmall?.copyWith(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ));
              }),
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
