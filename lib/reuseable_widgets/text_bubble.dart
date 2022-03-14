import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fx_pluses/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
class TextBubble extends StatelessWidget {
   TextBubble({Key? key, this.message,required this.isMe,required this.filePath,required this.isAdmin,required this.firstName}) : super(key: key);
  bool isMe;
  String? message;
  String? filePath;
  String? isAdmin;
  String? firstName;

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15,),
        child: Column(
            crossAxisAlignment:
            isMe  ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Text(
              //   '$textSender',
              //   style: const TextStyle(color: Colors.black54, fontSize: 12),
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                      offset: Offset(
                        1,
                        0,
                      ),
                    ),
                  ],
                  borderRadius: isMe
                      ? const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                      : const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: isMe ? whiteColor: isAdmin=='1'?buttonColor.withOpacity(0.7):Colors.green[300] ,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isAdmin=='1'?
                    Text('Admin',style: TextStyle(
                      color: whiteColor
                    ),): Text(firstName!,style: TextStyle(
                        color: textBlackColor.withOpacity(0.4)
                    ),),
                    message != null?
                    Text(
                      message!,
                    ):filePath==null?
                    Text(''):
                        InkWell(onTap:(){
                          List a=filePath!.split('/');
                          openFile(url: "http://192.168.18.17/FX_Pluses/FX_Pluses/public/"+filePath!, filename: '${a[1]}');
                          print('open file clicked');
                        },child: Container(
                         // height: MediaQuery.of(context).size.height * 0.12,
                          //width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.attach_file,color: buttonColor,size: 17,),
                                  Text('Attachment',style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: buttonColor
                                  ),),
                                ],
                              ),
                              Text('${filePath!.split('/')[1]}')
                            ],
                          ),

                        ))
                  ],
                ),
              ),
            ]),

    );
  }
  Future openFile({required String url,required String filename}) async{
    final file=await downloadFile(url,filename);
    if(file==null) {
      print('file is null');
      return;
    }
    print('path ${file.path}');
    OpenFile.open(file.path);


  }
  Future<File?> downloadFile(String url,String fileName) async{
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$fileName');
      final response = await Dio().get(
          url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0
          )
      );
      final raf = file.openSync(
          mode: FileMode.write
      );
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    }catch(e){
      print('error while downloading file $e');
      return null;
    }

  }
}
