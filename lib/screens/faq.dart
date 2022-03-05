import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/reuseable_widgets/appbar.dart';
import 'package:provider/provider.dart';

class FAQ extends StatelessWidget {
  static final String id='FAQ_Screen';
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbar(size: size, onPress: () {
          Navigator.pop(context);
        }, text: 'FAQ'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.9,
                child: ListView.builder(
                  itemCount: Provider.of<ApiDataProvider>(context,listen: false).faqsList.length,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.black12.withOpacity(0.07),
                    backgroundColor: Colors.black12.withOpacity(0.07),
                    // tilePadding: EdgeInsets.only(bottom: 10),

                    title: Text(
                      Provider.of<ApiDataProvider>(context,listen: false).faqsList[index].question,
                      style: TextStyle(
                          color: textBlackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    children: [
                      Container(
                        height: 10,
                        color: Colors.white,

                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: Colors.white
                        // ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        //height: size.height * 0.2,
                        width:size.width,
                        // margin: EdgeInsets.only(
                        //   top: 10
                        // ),
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(20),
                          //color: Colors.black12.withOpacity(0.07)
                        ),
                        child: Text(
                            Provider.of<ApiDataProvider>(context,listen: false).faqsList[index].answer,style: TextStyle(
                          fontSize: 15
                        ),
                        ),
                      )
                    ],
                  ),
                  ),
              ),
            );
        }

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
