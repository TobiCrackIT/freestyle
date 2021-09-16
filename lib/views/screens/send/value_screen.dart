import 'package:arbor/core/constants/arbor_colors.dart';
import 'package:arbor/core/constants/asset_paths.dart';
import 'package:arbor/core/enums/status.dart';
import 'package:arbor/core/providers/send_crypto_provider.dart';
import 'package:arbor/models/models.dart';
import 'package:arbor/views/screens/send/address_scanner.dart';
import 'package:arbor/views/screens/send/status_screen.dart';
import 'package:arbor/views/widgets/arbor_button.dart';
import 'package:arbor/views/widgets/arbor_textfield.dart';
import 'package:arbor/views/widgets/editting_controller.dart';
import 'package:arbor/views/widgets/layout/hide_keyboard_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValueScreen extends StatelessWidget {
  final addressFocusNode = FocusNode();
  final addressController = CustomTextEditingController();

  final Wallet wallet;
  ValueScreen({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Consumer<SendCryptoProvider>(builder: (_, model, __) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (model.walletBalanceStatus == Status.IDLE) {
          model.privateKey=wallet.privateKey;
          model.currentUserAddress=wallet.address;
          model.forkPrecision=wallet.fork.precision;
          model.forkName=wallet.fork.name;
          model.forkTicker=wallet.fork.ticker;
          model.setWalletBalance(wallet.balance);
        }
      });
      return Container(
        color: ArborColors.green,
        child: HideKeyboardContainer(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ArborColors.green,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    model.clearInput();
                    Navigator.pop(context, false);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: ArborColors.white,
                  ),
                ),
                title: Text(
                  'Enter Amount',
                  style: TextStyle(
                    color: ArborColors.white,
                  ),
                ),
                backgroundColor: ArborColors.green,
              ),
              body: Container(
                padding: EdgeInsets.fromLTRB(
                  10,
                  10,
                  10,
                  20,
                ),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight:
                    MediaQuery.of(context).size.height
                        - MediaQuery.of(context).padding.top
                        - MediaQuery.of(context).padding.bottom
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ArborColors.lightGreen.withOpacity(0.3),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                8,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: ArborColors.logoGreen,
                                backgroundImage: AssetImage(
                                  AssetPaths.logo,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${wallet.fork.name}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: ArborColors.white, fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  model.walletBalanceStatus == Status.LOADING
                                      ? 'Loading...'
                                      : '${model.readableBalance} ${wallet.fork.ticker.toUpperCase()}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: ArborColors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(flex: 1),
                        Text(
                          '${model.transactionValue} ${wallet.fork.ticker.toUpperCase()}',
                          style:
                          TextStyle(fontSize: 30.h, color: ArborColors.deepGreen),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ArborTextField(
                          hintText: "Tap to paste Recipient's Address",
                          focusNode: addressFocusNode,
                          controller: addressController
                            ..text = model.receiverAddress,
                          isDisabled: true,
                          onTextFieldTapped: () {
                            model.getClipBoardData();
                          },
                          errorMessage: model.addressErrorMessage,
                          onChanged: (v) => model.setReceiverAddress(v),
                          onIconPressed: () {
                            model.scannedData=false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressScanner(),
                              ),
                            );
                          },
                        ),
                        Container(
                          height: 290,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 5,
                                fit: FlexFit.loose,
                                child: NumericKeyboard(
                                  onKeyboardTap: (_) =>
                                      model.setTransactionValue(_),
                                  textColor: ArborColors.white,
                                  rightButtonFn: () => model.deleteCharacter(),
                                  rightIcon: Icon(
                                    Icons.arrow_back,
                                    color: ArborColors.white,
                                  ),
                                  leftButtonFn: () =>
                                      model.setTransactionValue('.'),
                                  leftIcon: Icon(
                                    Icons.adjust_sharp,
                                    color: ArborColors.white,
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: GestureDetector(
                                    onTap: () => model.useMax(),
                                    child: Container(
                                      // margin: EdgeInsets.symmetric(vertical: 16),
                                      // padding: EdgeInsets.symmetric(horizontal: 10),
                                      height: double.maxFinite * 0.75,
                                      decoration: BoxDecoration(
                                          color: ArborColors.transparent,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: ArborColors.lightGreen)
                                      ),
                                      child: Center(
                                        child: Text(
                                          'MAX',
                                          style: TextStyle(
                                              color: ArborColors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ArborButton(
                            backgroundColor: ArborColors.logoGreen,
                            disabled: !model.enableButton,
                            loading: false,
                            title: 'Continue',
                            onPressed: () async {
                              bool status = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StatusScreen(),
                                ),
                              );
                              if (status == true){
                                //model.getBalance();
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                        Spacer(flex: 1,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
