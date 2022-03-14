import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/model/contact_model.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:fx_pluses/reuseable_widgets/main_button.dart';
import 'package:provider/provider.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactUs extends StatefulWidget {
  static final String id='ContactUs_Screen';
   ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController messageController=TextEditingController();

  String? valuee;





  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(size: size, onPress: (){
          Navigator.pop(context);
        }, text: 'Contact us',check: true,),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 54),

                child: ConstrainedBox(
                  constraints:  BoxConstraints(
                    maxHeight: size.height * 0.2,//when it reach the max it will use scroll
                    maxWidth: size.width,
                  ),
                  child:  SizedBox(
                    height: size.height * 0.4,
                    child: TextField(
                      controller: messageController,
                      // textInputAction: TextInputAction.newline,
                      //keyboardType: TextInputType.multiline,
                      maxLines: 50,
                      //keyboardType: TextInputType.text,
                      //minLines: 7,
                      onChanged: (value){
                        print('$valuee');
                        valuee=value;
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color:Color(0xFF6F50FF)
                        ),
                        filled: true,
                        hintText: "Tell us how we can help",
                        border: InputBorder.none,

                      ),
                    ),
                  ),
                ),
              ),
              Text('Please write your graphic design, Lorem ipsum is a placeholder text commonly ',style: TextStyle(
                color: greyColor
              ),),

              SizedBox(height: size.height * 0.202,),
              MainButton(text: 'Submit', onPress: () async{
                print('aaaaaaaaaaaaaaaaaaaaa${valuee}');
                await Provider.of<ApiDataProvider>(context,listen: false).contactUs(context,
                    Provider.of<ApiDataProvider>(context,listen: false).bearerToken ,
                messageController.text);
              })
            ],
          ),
        ),
      ),
    );
  }
}
