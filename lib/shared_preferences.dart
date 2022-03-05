import 'package:fx_pluses/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPreference{
  int roleId=0;





  static String userIdKey='User_Id_Key';
  static String firstNameKey='First_Name_Key';
  static String lastNameKey='Last_Name_Key';
  static String userEmailKey = 'USER_EMAIL_KEY';
  static String walletKey='Wallet_Key';
  static String roleIdKey='Role_Id_Key';
  static String countryCodeKey='Country_Code_Key';
  static String ratingKey='Rating_Key';
  static String defaultCurrencyKey='Default_Currency_Key';
  static String photoUrlKey='Photo_Url_Key';
  static String bearerTokenKey='Bearer_Token_Key';
  static String userLoggedInKey = 'IS_LOGGED_IN';
  static String isSeenKey= 'IS_SEEN_KEY';



  static saveUserIdSharedPreferences(String userid) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(userIdKey, userid);
  }
  static saveFirstNameSharedPreferences(String name)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(firstNameKey,name );
  }
  static saveLastNameSharedPreferences(String name)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(lastNameKey,name );
  }
  static saveEmailSharedPreferences(String email)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(userEmailKey,email );
  }
  static saveWalletBalanceSharedPreferences(String amount) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(walletKey,amount );
  }
  static saveRoleIdSharedPreferences(int roleid) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setInt(roleIdKey, roleid);
  }
  static saveCountryCodeSharedPreferences(String countryCode) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(countryCodeKey,countryCode );
  }
  static saveRatingSharedPreferences(String rating) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(ratingKey,rating );
  }
  static saveDefaultCurrencySharedPreferences(String currency) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(defaultCurrencyKey,currency );
  }
  static savePhotoUrlSharedPreferences(String url) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(photoUrlKey,url );
  }
  static saveBearerTokenSharedPreferences(String token)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(bearerTokenKey,token );
  }
  static saveIsLoggedInSharedPreferences(bool isLoggedIn) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setBool(userLoggedInKey, isLoggedIn);
  }
  static Future<bool> saveIsSeenSharedPreference(int isSeen)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setInt(isSeenKey, isSeen);
  }






}