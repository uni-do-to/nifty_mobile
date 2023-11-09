import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:get/get.dart';
import 'package:date_format/date_format.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/form_field.dart';
import '../../../widgets/gender_radio.dart';
import '../controllers/register_controller.dart';

class AboutYouView extends GetView<RegisterController> {
  final RxString selectedGender = "Male".obs ;

  AboutYouView({Key? key}) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000 , 1 , 1),
        firstDate: DateTime(1900),
        lastDate: DateTime(2021));
    if (picked != null) {
      controller.dateOfBirthController.text = formatDate(picked , [dd, '/', mm, '/', yyyy]);
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Form(
      key: controller.yourInfoFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          NeuFormField(
            hintText: 'Your name',
            controller: controller.nameController,
            keyboardType: TextInputType.text,
            autocorrect: false,
            prefixIcon: const Icon(Icons.person),
            validator: (value) {
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          NeuFormField(
            hintText: 'Your Date of Birth ',
            controller: controller.dateOfBirthController,
            keyboardType: TextInputType.datetime,
            autocorrect: false,
            readOnly: true,
            onTap:() {
              // Call the _selectDate function when the text field is tapped.
              _selectDate(context);
            },
            prefixIcon: const Icon(Icons.date_range),
            validator: (value) {
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          ObxValue((state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GenderRadio(
                  label: "Male",
                  icon: Icons.male,
                  value: "Male",
                  groupValue: controller.selectedGender.value,
                  onChanged: (value) => controller.selectedGender.value = value.toString(),
                ),
                GenderRadio(
                  label: "Female",
                  icon: Icons.female,
                  value: "Female",
                  groupValue: controller.selectedGender.value,
                  onChanged: (value) => controller.selectedGender.value = value.toString(),
                ),
              ],
            );
          }, controller.selectedGender),

          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
