import 'package:fx_pluses/model/user_wallets_model.dart';
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

  static String photoUrlKey='Photo_Url_Key';
  static String bearerTokenKey='Bearer_Token_Key';
  static String userLoggedInKey = 'IS_LOGGED_IN';
  static String isSeenKey= 'IS_SEEN_KEY';
  static String defaultCurrencyIdKey='Default_Currency_Id_Key';
  static String defaultCurrencyNameKey='Default_Currency_Name_Key';
  static String defaultCurrencySymbolKey='Default_Currency_Symbol_Key';
  static String userWalletsKey='User_Wallets_Key';

  static String deviceTokenKey='Device_Token_Key';



  static saveDeviceToken(String token) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString(deviceTokenKey, token);
  }
  static saveUserWalletsSharedPreferences(String list) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove(userWalletsKey);
    await preferences.setString(userWalletsKey, list);
  }
  static saveUserIdSharedPreferences(int userid) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setInt(userIdKey, userid);
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
  static saveDefaultCurrencyIdSharedPreferences(int id) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setInt(defaultCurrencyIdKey, id);
  }
  static saveDefaultCurrencyNameSharedPreferences(String currencyName) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(defaultCurrencyNameKey,currencyName );
  }
  static saveDefaultCurrencySymbolSharedPreferences(String currencySymbol) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.setString(defaultCurrencySymbolKey,currencySymbol );
  }






}