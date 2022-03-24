
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/l10n/l10n.dart';
import 'package:fx_pluses/providers/language_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String countryCode='';
  PhoneNumber? phoneNumber;
  String currencyCode='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

        ],
      ),
      body: Column(
        children: [
          InternationalPhoneNumberInput(
            countries: ['PK','IN','US'],
            //formatInput: true,
            initialValue: phoneNumber,
            errorMessage: 'Invalid Phone Nummber',
            hintText: '3150001320',
            //textFieldController: phoneNumbercontroller,

            spaceBetweenSelectorAndTextField: 0,
            selectorButtonOnErrorPadding: 0,
            inputDecoration: InputDecoration(
              // filled: true,
              isDense: true,
              border: InputBorder.none,
            ),

            autoValidateMode: AutovalidateMode.disabled,
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: 0,
              useEmoji: true,
              showFlags: true,
              //trailingSpace: true
            ),
            onInputValidated: (bool value) {
              // numberValid = value;
            },
            onInputChanged: (value) async{
              print('${value.phoneNumber}');
              countryCode = value.isoCode.toString();
              currencyCode=CountryPickerUtils.getCountryByIsoCode(countryCode).currencyCode.toString();

              // currencyCode= await NumberFormat.simpleCurrency(locale: Platform.localeName).currencyName.toString();

              print('phone number is $value');
              print(countryCode+" and "+currencyCode);
              if(countryCode=='PK'){

              setState(() {
                Provider.of<LanguageProvider>(context,listen: false).setLocale(L10n.all[3]);
              });
              }else{
                if(countryCode=='IN'){


                    Provider.of<LanguageProvider>(context,listen: false).setLocale(L10n.all[4]);

                  setState(() {

                  });
                }
              }
              phoneNumber = value;
            },
          ),
          Center(
            child: Text(AppLocalizations.of(context)!.helloWorld),
          ),
        ],
      ),
    );
  }
}
