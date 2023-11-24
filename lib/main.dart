import 'package:cy_app/views/account/findPasswordPage.dart';
import 'package:cy_app/views/account/signup.dart';
import 'package:cy_app/views/account/smsSignin.dart';
import 'package:cy_app/views/agreement/hashRateAgreementPage.dart';
import 'package:cy_app/views/discovery/newsPage.dart';
import 'package:cy_app/views/mall/mainPage.dart';
import 'package:cy_app/views/my/earning/groupRecordPage.dart';
import 'package:cy_app/views/my/earning/invitePage.dart';
import 'package:cy_app/views/my/earning/inviteRecordPage.dart';
import 'package:cy_app/views/my/earning/profitRecordPage.dart';
import 'package:cy_app/views/my/earning/stakingRecordPage.dart';
import 'package:cy_app/views/home/announceListPage.dart';
import 'package:cy_app/views/home/announcePage.dart';
import 'package:cy_app/views/home/confirmOrder.dart';
import 'package:cy_app/views/my/accountPage.dart';
import 'package:cy_app/views/my/addAddressPage.dart';
import 'package:cy_app/views/my/addressPage.dart';
import 'package:cy_app/views/my/assetPage.dart';
import 'package:cy_app/views/my/changeFundPasswordPage.dart';
import 'package:cy_app/views/my/depositWithdrawPage.dart';
import 'package:cy_app/views/my/feedbackPage.dart';
import 'package:cy_app/views/my/innerTransferPage.dart';
import 'package:cy_app/views/my/kycPage.dart';
import 'package:cy_app/views/my/orderPage.dart';
import 'package:cy_app/views/my/recordDepositPage.dart';
import 'package:cy_app/views/my/recordStakedPage.dart';
import 'package:cy_app/views/my/recordWithdrawPage.dart';
import 'package:cy_app/views/my/settingPage.dart';
import 'package:flutter/material.dart';
import 'views/discovery/mainPage.dart';
import 'views/my/earning/mainPage.dart';
import 'views/my/mainPage.dart';
import 'views/account/signin.dart';
import 'views/splash_screen.dart';

void main() => runApp(MyApp());

class Global {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Global.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 28, 33, 49),
        buttonColor: Color.fromARGB(255, 28, 33, 49),
        scaffoldBackgroundColor: Color.fromARGB(255, 21, 21, 30),
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 21, 21, 30)),
        brightness: Brightness.dark,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
        primaryIconTheme: IconThemeData(color: Colors.white),
        tabBarTheme: TabBarTheme(labelColor: Colors.white),
        buttonTheme: ButtonThemeData(
            buttonColor: Color.fromARGB(255, 28, 33, 49), textTheme: ButtonTextTheme.primary),
      ),
      home: SplashScreen(),
      routes: {
        "/discovery": (BuildContext context) => new DiscoveryPage(),
        "/news": (BuildContext context) => new NewsPage(),

        "/agreement": (BuildContext context) => new HashRateAgreementPage(),

        "/invite": (BuildContext context) => new InvitePage(),
        "/inviteRecord": (BuildContext context) => new InviteRecordPage(),

        "/announce": (BuildContext context) => new AnnouncePage(),
        "/announces": (BuildContext context) => new AnnounceListPage(),

        // 订单
        "/order": (BuildContext context) => new ConfirmOrderPage(),

        //　设置路由
        "/login": (BuildContext context) => new LoginPage(),
        "/signup": (BuildContext context) => new SignupPage(),
        "/smslogin": (BuildContext context) => new SMSSigninPage(),

        // Fund
        "/fund/record/deposit": (BuildContext context) => new RecordDepositPage(),
        "/fund/record/withdraw": (BuildContext context) => new RecordWithdrawPage(),
        "/fund/record/staking": (BuildContext context) => new StakingRecordPage(),
        "/fund/record/profit": (BuildContext context) => new ProfitRecordPage(),
        "/fund/password":(BuildContext context) => new ChangeFundPasswordPage(),

        //账户
        "/account": (BuildContext context) => new AccountPage(),
        "/account/kyc": (BuildContext context) => new KycPage(),
        "/account/password": (BuildContext context) => new FindPasswordPage(),

        //商城
        "/mall": (BuildContext context) => new MallPage(),


        //我的
        "/my": (BuildContext context) => new MyPage(),
        "/my/earning": (BuildContext context) => new EarningPage(),
        // "/my/changePassword": (BuildContext context) => new ChangePasswordPage(),
        "/my/asset": (BuildContext context) => new MyAssetPage(),
        "/my/order": (BuildContext context) => new OrderPage(),
        "/my/address": (BuildContext context) => new AddressPage(),
        "/my/address/add": (BuildContext context) => new AddAddressPage(),
        "/my/asset/deposit": (BuildContext context) => new DepositWithdrawPage(),
        "/my/asset/withdraw": (BuildContext context) => new DepositWithdrawPage(),
        "/my/asset/history": (BuildContext context) => new DepositWithdrawPage(),
        "/my/asset/transfer": (BuildContext context) => new DepositWithdrawPage(),
        "/my/groupRecord": (BuildContext context) => new GroupRecordPage(),
        "/my/asset/staked": (BuildContext context) => new RecordStakedPage(),
        "/setting": (BuildContext context) => new SettingPage(),
        "/feedback": (BuildContext context) => new FeedbackPage(),

      },
    );
  }
}
