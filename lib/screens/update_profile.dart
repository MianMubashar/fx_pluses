
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../reuseable_widgets/appbar.dart';
class UpdateProfile extends StatefulWidget {

  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  PhoneNumber? phoneNumber;

  bool numberValid=false;

  String countryCode='';

  XFile? result;

  String? buisnessName;

  PhoneNumber? mobileNummber;

  String code='';

   TextEditingController phoneNumbercontroller = TextEditingController();

   TextEditingController buisnessController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    // print('navigation history ${NavigationHistoryObserver().top}');
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbar(
            size: size,
            onPress: () {
              Navigator.pop(context);
            },
            text: 'Profile Information',
            check: true,
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Provider.of<ApiDataProvider>(context,listen: false).roleId == 4?
              const Text(
                'Business Name',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ):Container(),
              Provider.of<ApiDataProvider>(context,listen: false).roleId == 4?
              SizedBox(
                height: 8,
              )
                  :Container(),
              Provider.of<ApiDataProvider>(context,listen: false).roleId == 4?Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(

                  controller: buisnessController,
                  decoration: InputDecoration(
                      hintText: Provider.of<ApiDataProvider>(context,listen: true).buisnessName == null ||
                          Provider.of<ApiDataProvider>(context,listen: true).buisnessName == 'null'  ||
                          Provider.of<ApiDataProvider>(context,listen: true).buisnessName == '' ? 'Business name':
                                Provider.of<ApiDataProvider>(context,listen: true).buisnessName,
                      helperStyle: TextStyle(color: blackColor),
                      isDense: true,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: (value) {
                    buisnessName = value;
                    Provider.of<ApiDataProvider>(context,listen: false).setBuisnessName(buisnessName);
                    print(value);
                  },
                  // onSubmitted: (value){
                  //   buisnessName=value;
                  //   Provider.of<ApiDataProvider>(context,listen: false).setBuisnessName(buisnessName);
                  // },
                ),
              ):Container(),
              Text(
                'Phone Number',
                textAlign: TextAlign.start,
                style: TextStyle(color: greyColor),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20,top: 10),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InternationalPhoneNumberInput(
                   //countries: ['PK'],
                  //formatInput: true,
                  initialValue: PhoneNumber(phoneNumber: Provider.of<ApiDataProvider>(context,listen: true).contact,
                      isoCode: Provider.of<ApiDataProvider>(context,listen: true).countryCode),

                  errorMessage: 'Invalid Phone Number',
                  hintText: '${Provider.of<ApiDataProvider>(context,listen: false).contact}',
                  textFieldController: phoneNumbercontroller,

                  spaceBetweenSelectorAndTextField: 0,
                  selectorButtonOnErrorPadding: 0,
                  inputDecoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  autoValidateMode: AutovalidateMode.always,
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    setSelectorButtonAsPrefixIcon: true,
                    leadingPadding: 0,
                    useEmoji: true,
                    showFlags: true,
                    //trailingSpace: true
                  ),
                  onInputValidated: (bool value) {
                    numberValid=value;
                  },

                  onInputChanged: (value) async{
                    print('${value.phoneNumber}');
                    countryCode = value.isoCode.toString();
                    code=countryCode;
                    print('phone number is $value');
                    print(countryCode);
                    phoneNumber = value;
                    await Provider.of<ApiDataProvider>(context,listen: false).setUpdatedContact(phoneNumber.toString());
                    await Provider.of<ApiDataProvider>(context,listen: false).setCountryCode(phoneNumber!.isoCode.toString());
                    await Provider.of<ApiDataProvider>(context,listen: false).setRegisterUserCountryName(
                        CountryPickerUtils.getCountryByIsoCode(phoneNumber!.isoCode.toString()).name.toString()
                    );

                  },

                  // onSaved: (data){
                  //   print(data.phoneNumber);
                  //   phoneNumber=data;
                  //   countryCode=data.isoCode.toString();
                  // },
                  onSubmit: (){
                    mobileNummber=phoneNumber;
                    code=countryCode;
                    Provider.of<ApiDataProvider>(context,listen: false).setUpdatedContact(phoneNumber.toString());
                    Provider.of<ApiDataProvider>(context,listen: false).setCountryCode(phoneNumber!.isoCode.toString());
                    Provider.of<ApiDataProvider>(context,listen: false).setRegisterUserCountryName(
                        CountryPickerUtils.getCountryByIsoCode(phoneNumber!.isoCode.toString()).name.toString()
                    );
                  },


                ),
              ),
              Provider.of<ApiDataProvider>(context,listen: true).idFile==null ||
                  Provider.of<ApiDataProvider>(context,listen: true).idFile==''?
              InkWell(
                onTap: ()async{
                  final ImagePicker _picker = ImagePicker();
                   result=await _picker.pickImage(source: ImageSource.gallery);
                 // result=await FilePicker.platform.pickFiles(type: FileType.any,allowedExtensions: null,allowMultiple: false);
                  if (result == null) {
                  print("No file selected");
                  }else{
                    await Provider.of<ApiDataProvider>(context,listen: false).setIdFileForLocal(result!.path.toString());
                  }
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Select Id'),
                        Container(
                          height: size.height * 0.04,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined,color: whiteColor,),
                              Text(Provider.of<ApiDataProvider>(context,listen: true).idFileForlocal == null
                                  ?'Select'
                                  :'Selected',style: const TextStyle(
                                color: textWhiteColor
                              ),)
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected Id',textAlign: TextAlign.start,style: TextStyle(
                        color: greyColor
                      ),),
                      SizedBox(height: 5,),
                      Container(
                height: size.height * 0.35,
                width: size.width,
                child: Image.network(profile_url + Provider.of<ApiDataProvider>(context,listen: true).idFile!,fit: BoxFit.contain,),
                                  ),
                    ],
                  ),
              SizedBox(height: 20,),
              MainButton(text: 'Update', onPress: () async{
                print('abcd ${phoneNumbercontroller.text.isEmpty}');
                print('abcd ${buisnessController.text.isEmpty}');
                print(Provider.of<ApiDataProvider>(context,listen: false).contact+"   "+ phoneNumber!.phoneNumber.toString());
                if(result == null && buisnessController.text.isEmpty &&  phoneNumber!.phoneNumber.toString() == Provider.of<ApiDataProvider>(context,listen: false).contact){
                  Provider.of<ApiDataProvider>(context,listen: false).showSnackbar(context, 'Enter data to update', redColor);
                }else{
                  FocusManager.instance.primaryFocus?.unfocus();
                  if(phoneNumber!.phoneNumber.toString() == Provider.of<ApiDataProvider>(context,listen: false).contact){
                    await Provider.of<ApiDataProvider>(context,listen: false).updateProfile(context,
                        Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                        '', '',
                        result == null ? null: result!.path.toString(),
                        'id_file',
                        null,
                        buisnessController.text.isEmpty ? null : buisnessController.text,
                        null,
                        null);
                  }else{
                    Provider.of<ApiDataProvider>(context,listen: false).setContact(phoneNumber.toString());
                    await Provider.of<ApiDataProvider>(context,listen: false).otpRequest(phoneNumber, context, 1);

                    // await Provider.of<ApiDataProvider>(context,listen: false).updateProfile(context,
                    //     Provider.of<ApiDataProvider>(context,listen: false).bearerToken,
                    //     '', '',
                    //     result == null ? null: result!.files.single.path.toString(),
                    //     'id_file',
                    //     phoneNumber==null?null:phoneNumber.toString(),
                    //     buisnessName==null ? null : buisnessName,
                    //     countryCode==null ? null: countryCode,
                    //     countryCode==null ? null: CountryPickerUtils.getCountryByIsoCode(countryCode).name.toString());
                  }


                }

                }),
            ],
          ),
        ),
      ),
    );
  }
}
