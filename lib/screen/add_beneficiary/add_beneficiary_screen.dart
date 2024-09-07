import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/screen/top_up/top_up_screen.dart';
import 'package:mobile_top_up/services/exceptions/exceptions.dart';
import 'package:mobile_top_up/services/exceptions/handle_exception.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager_provider.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';
import 'package:mobile_top_up/widgets/gradient_button.dart';
import 'package:mobile_top_up/widgets/my_text_form_field.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  static const String routeName = '/AddBeneficiaryScreen';

  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final nickNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formStateKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nickNameController.dispose();
    phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Beneficiary'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SafeArea(
          child: Form(
        key: formStateKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            MyTextFormField(
              textEditingController: nickNameController,
              label: 'Nick Name',
              icon: Icons.person,
              textInputType: TextInputType.name,
              textInputFormatter: [LengthLimitingTextInputFormatter(20)],
            ),
            const Gap(10),
            MyTextFormField(
              textEditingController: phoneNumberController,
              label: 'Phone Number',
              icon: Icons.phone,
              textInputType: TextInputType.phone,
              textInputFormatter: [
                LengthLimitingTextInputFormatter(13),
              ],
            ),
            const Gap(30),
            GradientButton(
              onTap: _onTapAddBeneficiaryBtn,
              text: 'Add',
            )
          ],
        ),
      )),
    );
  }

  void _onTapAddBeneficiaryBtn() async {
    if (!formStateKey.currentState!.validate()) return;

    EasyLoading.show(maskType: EasyLoadingMaskType.black);

    String message = "";
    bool isSuccess;
    final beneficiaryModel = BeneficiaryModel(
        nickname: nickNameController.text,
        phoneNumber: phoneNumberController.text);

    try {
      await TopUpManagerProvider.of(context).addBeneficiary(
        beneficiaryModel.nickname,
        beneficiaryModel.phoneNumber,
      );

      message = "Successfully added beneficiary";

      isSuccess = true;
    } catch (e) {
      AppException appException = HandleException.handleException(e);

      message = appException.message;
      isSuccess = false;
    }

    EasyLoading.dismiss();
    if (mounted) showStatus(context, isSuccess, message, beneficiaryModel);
  }

  void showStatus(BuildContext context, bool isSuccess, String message,
      BeneficiaryModel? beneficiaryModel) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: context.mqHeight * 0.4,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Gap(20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.headlineSmall!.bold,
                ),
                const Gap(20),
                Icon(
                  isSuccess ? Icons.check_circle : Icons.dangerous,
                  color: AppTheme.purpleAccentColor,
                  size: context.mqHeight * 0.13,
                ),
                Gap(context.mqHeight * 0.05),
                GradientButton(
                  onTap: () {
                    Navigator.pop(context, isSuccess);
                    if (isSuccess) {
                      Navigator.pop(context, isSuccess);
                    }
                  },
                  text: 'Back',
                ),
                const Gap(10),
                if (isSuccess)
                  GradientButton(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TopUpScreen.routeName,
                        arguments: beneficiaryModel,
                      );
                    },
                    text: 'Pay Now',
                  ),
              ],
            ),
          );
        });
  }
}
