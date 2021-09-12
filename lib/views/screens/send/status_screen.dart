import 'package:arbor/core/constants/arbor_colors.dart';
import 'package:arbor/core/constants/asset_paths.dart';
import 'package:arbor/core/enums/status.dart';
import 'package:arbor/core/providers/send_crypto_provider.dart';
import 'package:arbor/views/widgets/arbor_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SendCryptoProvider>(builder: (_, model, __) {
      return Container(
        color: ArborColors.green,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ArborColors.green,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '${model.appBarTitle}',
                style: TextStyle(color: ArborColors.white),
              ),
              automaticallyImplyLeading: false,
              leading: model.sendCryptoStatus == Status.IDLE
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                        model.close();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: ArborColors.white,
                      ),
                    )
                  : null,
              backgroundColor: ArborColors.green,
            ),
            body: Container(
              padding: EdgeInsets.all(40),
              child: Builder(
                builder: (_) {
                  if (model.sendCryptoStatus == Status.LOADING) {
                    return _processingView(model);
                  } else if (model.sendCryptoStatus == Status.SUCCESS) {
                    return _successView(context, model);
                  } else if (model.sendCryptoStatus == Status.ERROR) {
                    return _errorView(context, model);
                  } else {
                    return _summaryView(context, model);
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _processingView(SendCryptoProvider model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        SvgPicture.asset(
          AssetPaths.transactionSend,
          fit: BoxFit.cover,
          height: 100,
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Text(
          'Sending',
          style: TextStyle(
            color: ArborColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        Text(
          'Transaction in progress...',
          style: TextStyle(
            color: ArborColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }

  Widget _successView(BuildContext context, SendCryptoProvider model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        SvgPicture.asset(
          AssetPaths.walletSendSuccess,
          fit: BoxFit.cover,
          height: 150,
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        Text(
          'Success!',
          style: TextStyle(
            color: ArborColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        Text(
          '${model.forkName}(${model.forkTicker.toUpperCase()}) sent',
          style: TextStyle(
            color: ArborColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
        ArborButton(
          backgroundColor: ArborColors.logoGreen,
          disabled: false,
          loading: false,
          title: 'Continue',
          onPressed: () {
            Navigator.pop(context, true);
            model.close();
          },
        ),
      ],
    );
  }

  Widget _errorView(BuildContext context, SendCryptoProvider model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        SvgPicture.asset(
          AssetPaths.walletSendError,
          fit: BoxFit.cover,
          height: 150,
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
        Text(
          'Oops!',
          style: TextStyle(
            color: ArborColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        Text(
          '${model.errorMessage}',
          style: TextStyle(
            color: ArborColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(),
        ),
        ArborButton(
          backgroundColor: ArborColors.logoGreen,
          disabled: false,
          loading: false,
          title: 'Go Back',
          onPressed: () {
            Navigator.pop(context, false);
            model.close();
          },
        ),
      ],
    );
  }

  Widget _summaryView(BuildContext context, SendCryptoProvider model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        SvgPicture.asset(
          AssetPaths.transactionSend,
          fit: BoxFit.cover,
          height: 100,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
            color: ArborColors.deepGreen,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sending',
                style: TextStyle(
                  color: ArborColors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                '-${model.transactionValue}${model.forkTicker.toUpperCase()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ArborColors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
            color: ArborColors.deepGreen,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Sending to',
                style: TextStyle(
                  color: ArborColors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                '${model.receiverAddress}',
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: ArborColors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        ArborButton(
          backgroundColor: ArborColors.logoGreen,
          disabled: false,
          loading: false,
          title: 'Send',
          onPressed: () => model.authoriseTransaction(),
        ),
      ],
    );
  }
}
