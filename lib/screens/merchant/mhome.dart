import 'package:flutter/material.dart';
import 'package:fx_pluses/providers/api_data_provider.dart';
import 'package:fx_pluses/screens/merchant/mprofile.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'mtransaction_requests.dart';


class MHome extends StatefulWidget {
  static final String id='MHome_Screen';
  const MHome({Key? key}) : super(key: key);

  @override
  _MHomeState createState() => _MHomeState();
}

class _MHomeState extends State<MHome> {

  String? balance;
  String? profilePhoto;
  getData() async{
    await Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequests(context,
        Provider.of<ApiDataProvider>(context,listen: false).bearerToken);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Home',
                  style: TextStyle(color: textBlackColor, fontSize: 17,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>MProfile()));
                  },
                  child: Provider.of<ApiDataProvider>(context,listen: true).photoUrl !=null ?CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage((Provider.of<ApiDataProvider>(context,listen: true).photoUrl.contains("https") ||
                        Provider.of<ApiDataProvider>(context,listen: true).photoUrl.contains("http")) ?
                    Provider.of<ApiDataProvider>(context,listen: true).photoUrl :
                    (profile_url + Provider.of<ApiDataProvider>(context,listen: true).photoUrl)),
                  ):CircularProgressIndicator(color: buttonColor,)
                ),
              )
            ],
          ),
        ),
      body: Padding(
        padding: EdgeInsets.only(left: 15,right: 15,top:15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.13,
                width: size.width,
                padding: EdgeInsets.only(left: 10, right: 10),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     heightFactor: 0.4,
                    //     child: IconButton(
                    //         onPressed: () {},
                    //         icon: Image.asset(
                    //           'assets/images/cancelicon.png',
                    //           height: size.height * 0.02,
                    //         ))),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/ellipse.png',
                              width: size.width * 0.22,
                            ),
                            Positioned(
                              child: Image.asset(
                                'assets/images/happy.png',
                                width: size.width * 0.14,
                              ),
                              top: size.height * 0.02,
                              left: size.width * 0.040,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.6,
                              child: Text(
                                'Welcome ${Provider.of<ApiDataProvider>(context,listen: false).firstName==null ?"":
                                Provider.of<ApiDataProvider>(context,listen: false).firstName}',
                                textAlign: TextAlign.start,overflow: TextOverflow.fade,maxLines: 2,softWrap: false,
                                style: TextStyle(
                                    color: textWhiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              'Please Process you payments.',
                              style: TextStyle(
                                color: textWhiteColor,
                                fontSize: 15,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.20,
                width: size.width,
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                margin: EdgeInsets.only(bottom: 38),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: gradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Available Balance',
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        RichText(text:  TextSpan(
                            text: Provider.of<ApiDataProvider>(context,listen: false).balance==null ? '':Provider.of<ApiDataProvider>(context,listen: false).balance,
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                            children: [
                              TextSpan(
                                  text: Provider.of<ApiDataProvider>(context,listen: false).defaultCurrencyName,
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 10
                                  )
                              )
                            ]
                        )),
                      ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          child: Text('Please add balance to proceed transaction',style: TextStyle(
                              color: whiteColor,
                              fontSize: 15
                          ),maxLines: 2,),
                        ),
                        // SizedBox(width: 10,),
                        // InkWell(
                        //   onTap: (){
                        //     print('add balance clicked');
                        //     print(Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList.length);
                        //   },
                        //   child: Text('Add Balance +',style: TextStyle(
                        //       color: whiteColor,
                        //       fontSize: 15,
                        //       fontWeight: FontWeight.w500
                        //   ),),
                        // )
                      ],
                    ),

                  ],
                ),
              ),
              Text(
                'Transaction Requests',
                style: TextStyle(
                    color: textBlackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              SizedBox(height: 20,),


              Provider.of<ApiDataProvider>(context,listen: false).merchantTransactionRequestsList.length==0?
              Align(
                alignment: Alignment.center,
                child: Text('No Requests found',style: TextStyle(
                    color: textBlackColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),),
              ):Container(
                height: size.height * 0.4,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return transactionRequestWidget(size: size,index: index,);
                    }),
              )
            ],
          ),
        ),
      ),

    );
  }
}
