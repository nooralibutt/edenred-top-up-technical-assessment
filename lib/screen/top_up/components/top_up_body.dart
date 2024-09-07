import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:mobile_top_up/model/beneficiary/beneficiary_model.dart';
import 'package:mobile_top_up/model/beneficiary_top_up_info.dart';
import 'package:mobile_top_up/screen/home/top_up_home_screen.dart';
import 'package:mobile_top_up/screen/top_up/top_up_screen.dart';
import 'package:mobile_top_up/services/exceptions/handle_exception.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager.dart';
import 'package:mobile_top_up/services/top_up/top_up_manager_provider.dart';
import 'package:mobile_top_up/utilities/app_theme.dart';
import 'package:mobile_top_up/widgets/gradient_button.dart';

class TopUpBody extends StatefulWidget {
  final BeneficiaryTopUpInfo model;
  final BeneficiaryModel beneficiary;
  const TopUpBody(this.model, this.beneficiary, {super.key});

  @override
  State<TopUpBody> createState() => _TopUpBodyState();
}

class _TopUpBodyState extends State<TopUpBody> {
  double? selectedOption;
  double userBalance = 0;

  @override
  void initState() {
    userBalance = widget.model.balance;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: TopUpManager.topUpOptions.map((option) {
            return ChoiceChip(
              label: Text('AED ${option.toStringAsFixed(0)}'),
              selected: selectedOption == option,
              onSelected: (bool isSelected) {
                setState(() {
                  selectedOption = option;

                  _setRemainingAmount(selectedOption.toString());
                });
              },
              selectedColor: Colors.blue,
              backgroundColor: Colors.grey[200],
              labelStyle: TextStyle(
                color: selectedOption == option ? Colors.white : Colors.black,
              ),
            );
          }).toList(),
        ),
        const Gap(20),
        Text('Remaining $userBalance'),
        const Gap(20),
        GradientButton(
          onTap: _onTapTopUp,
          text: 'Pay',
        ),
      ],
    );
  }

  void _onTapTopUp() async {
    if (selectedOption == null) return;

    bool isSuccess = false;
    String message;

    EasyLoading.show(maskType: EasyLoadingMaskType.black);

    try {
      final result = await TopUpManagerProvider.of(context)
          .topUp(widget.beneficiary.phoneNumber, selectedOption!, widget.model);
      if (result == true) {
        isSuccess = true;
        message = "Transaction Successful";
      } else {
        isSuccess = false;
        message = "Transaction declined";
      }
    } catch (e) {
      message = HandleException.handleException(e).message;
      isSuccess = false;
    }
    EasyLoading.dismiss();

    if (!mounted) return;

    showMyModalBottomSheet(context, message, isSuccess, widget.beneficiary);
  }

  void _setRemainingAmount(String value) {
    if (value.isEmpty) {
      setState(() {
        userBalance = widget.model.balance;
      });
      return;
    }

    final parsedValue = double.tryParse(value);

    if (parsedValue != null) {
      setState(() {
        userBalance = widget.model.balance;
        userBalance -= parsedValue;
      });
    } else {
      setState(() {
        userBalance = widget.model.balance;
      });
    }
  }

  static void showMyModalBottomSheet(
    BuildContext context,
    String message,
    bool isSuccess,
    BeneficiaryModel beneficiary,
  ) {
    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: context.mqHeight * 0.45,
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
                const Gap(20),
                GradientButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, TopUpHomeScreen.routeName);
                  },
                  text: 'Finish',
                ),
                const Gap(20),
                if (isSuccess)
                  GradientButton(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, TopUpScreen.routeName,
                          arguments: beneficiary);
                    },
                    text: 'Recharge Again',
                  ),
                if (!isSuccess)
                  GradientButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    text: 'Back',
                  ),
              ],
            ),
          );
        });
  }
}
