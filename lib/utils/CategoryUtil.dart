import 'package:flustars/flustars.dart';
import 'package:intl/intl.dart';

class SdopCategoryUtils {

  String Convert(String category) {
    String result;
    switch (category) {
      case("MINER"):
        result="挖矿";
        break;
      case ("DEPOSIT"):
        result="充值";
        break;
      case ("WITHDRAWAL"):
        result="提币";
        break;
      case ("STAKING"):
        result="质押";
        break;
      case ("REWARD_BUY"):
        result="分红";
        break;
      case ("PRODUCT_BUY"):
        result="产品购买";
        break;
      case ("PROFIT25"):
        result="25%收益";
        break;
      case ("PROFIT75"):
        result="75%收益";
        break;
      case ("WITHDRAWAL_INNER"):
        result="内部提币";
        break;
      case ("DEPOSIT_INNER"):
        result="内部充币";
        break;
      default:
        result="";
        break;
    }
    return result;
  }

  String reverseConvert(String category) {
    String result;
    switch (category) {
      case ("充值"):
        result="DEPOSIT";
        break;
      case ("提币"):
        result="WITHDRAWAL";
        break;
      case ("质押"):
        result="STAKING";
        break;
      case ("分红"):
        result="REWARD_BUY";
        break;
      case ("产品购买"):
        result="PRODUCT_BUY";
        break;
      case ("25%收益"):
        result="PROFIT25";
        break;
      case ("75%收益"):
        result="PROFIT75";
        break;
      case ("内部提币"):
        result="WITHDRAWAL_INNER";
        break;
      case ("内部充币"):
        result="DEPOSIT_INNER";
        break;
      default:
        result="";
        break;
    }
    return result;
  }
}
