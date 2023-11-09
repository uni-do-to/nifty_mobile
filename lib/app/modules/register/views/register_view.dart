import 'package:date_format/date_format.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:nifty_mobile/app/modules/register/views/about_you_view.dart';
import 'package:nifty_mobile/app/utils/size_utils.dart';
import 'package:nifty_mobile/app/widgets/small_action_button.dart';

import '../../../widgets/form_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      controller.dateOfBirthController.text = formatDate(picked , [dd, '/', mm, '/', yyyy]);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: NeumorphicAppBar(
          title: Center(child: Text("Create new Account")),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ObxValue((state) {
                return NeumorphicProgress(percent: state.value / 3 , curve: Curves.easeIn, duration: Duration(seconds: 1), ) ;
              }, controller.currentStep),

          ),

          Padding(
            padding: const EdgeInsets.all(32.0),
            child: AboutYouView(),

          ),
          Expanded(child: Container(),) ,
          Container(
            padding: EdgeInsets.all(20),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Visibility(
                      visible:controller.currentStep.value > 0 ,
                      child: SmallActionButton(
                        text: 'Back',
                        onPressed: () => controller.currentStep.value--,
                        // Optionally, specify width and height
                      ),
                    ),
                  SmallActionButton(
                    text: 'Next',
                    onPressed: () {
                      if (controller.yourInfoFormKey.currentState?.validate() ?? false) {
                        controller.currentStep.value++;
                      }
                    },
                    // Optionally, specify width and height
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
