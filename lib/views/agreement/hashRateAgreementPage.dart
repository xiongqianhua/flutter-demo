import 'package:cy_app/api/app.dart';
import 'package:cy_app/utils/DateUtil.dart';
import 'package:flutter/material.dart';

class HashRateAgreementPage extends StatefulWidget {
  // final initPage;
  //
  // HashRateAgreementPage({Key key, this.initPage}) : super(key: key);

  @override
  _HashRateAgreementPageState createState() {
    return _HashRateAgreementPageState();
  }
}

class _HashRateAgreementPageState extends State<HashRateAgreementPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.context;
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("用户协议"),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Text(
              "用户服务协议",
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Container(
          //     alignment: Alignment.topLeft,
          //     padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          //     child: Text(SdopDateUtils().tsToDate((_news.isEmpty ? 0 : _news["ts"]) * 1000000))),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("一、总则")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text('1.1用户应当同意本协议的条款并按照页面上的提示完成全部的注册程序。用户在进行注册程序过程中勾选"我已阅读并接受"模块即表示用户与产品名称达成协议,完全接受本协议项下的全部条款。')),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "1.2用户注册成功后,超越矿池将给予每个用户一个用户帐号及相应的密码,该用户帐号和密码由用户负责保管;用户应当对以其用户帐号进行的所有活动和事件负法律责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "1.3用户可以使用超越矿池各个频道单项服务,当用户使用超越矿池各单项服务时,用户的使用行为视为其对该单项服务的服务条款以及超越矿池在该单项服务中发出的各类公告的同意。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("二、注册信息和隐私保护")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "2.1超越矿池帐号(即超越矿池用户ID)的所有权归超越矿池,用户完成注册申请后,获得超越矿池帐号的使用权。所有原始键入的资料将引用为注册资料。如果因注册信息不真实而引起的问题,并对问题发生所带来的后果,超越矿池不负任何责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "2.2用户不应将其帐号、密码转让或出借予他人使用。如用户发现其帐号遭他人非法使用,应立即通知超越矿池。因黑客行为或用户的保管疏忽导致帐号、密码遭他人非法使用,超越矿池不承担任何责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("2.3超越矿池不对外公开或向第三方提供单个用户的注册资料,除非:")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("a.事先获得用户的明确授权;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("b.只有透露您的个人资料,才能提供您所要求的产品和服务；")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("c.根据有关的法律法规要求;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("d.按照相关政府主管部门的要求;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("e.为维护产品名称的合法权益。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "2.4在您注册超越矿池,使用其他超越矿池产品或服务,访问产品名称网页时,超越矿池会收集您的个人身份识别资料,并会将这些资料用于:改进为你提供的服务及网页内容。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("三、使用规则")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "3.1用户在使用超越矿池服务时,必须遵守中华人民共和国相关法律法规的规定,用户应同意将不会利用本服务进行任何违法或不正当的活动,包括但不限于下列行为:")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("a.上载、展示、张贴、传播或以其它方式传送含有下列内容之一的信息:")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("b.不得为任何非法目的而使用网络服务系统")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("不利用超越矿池服务从事以下活动:")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("a.未经允许,进入计算机信息网络或者使用计算机信息网络资源的;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("b.未经允许,对计算机信息网络功能进行删除、修改或者增加的")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("c.未经允许,对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("d.故意制作、传播计算机病毒等破坏性程序的;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("e.其他危害计算机信息网络安全的行为。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "3.2用户违反本协议或相关的服务条款的规定,导致或产生的任何第三方主张的任何索赔、要求或损失,包括合理的律师费,您同意赔偿合作公司、关联公司,并使之免受损害。对此,超越矿池有权视用户的行为性质,采取包括但不限于删除用户发布信息内容、暂停使用许可、终止服务、限制使用、回收产品名称帐号、追究法律责任等措施。对恶意注册超越矿池帐号或利用超越矿池帐号进行违法活动、捣乱、强扰、欺骗、其他用户以及其他违反本协议的行为,超越矿池有权回收其帐号。同时,超越矿池会视司法部门的要求,协助调查。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("3.3用户不得对本服务任何部分或本服务之使用或获得,进行复制、拷贝、出售、转售或用于任何其它商业目的。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "3.4用户须对自己在使用超越矿池服务过程中的行为承担法律责任。用户承担法律责任的形式包括但不限于:对受到侵害者进行赔偿,以及在超越矿池首先承担了因用户行为导致的行政处罚或侵权损害赔偿责任后,用户应给予超越矿池等额的赔偿。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("四、服务内容")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("4.1超越矿池网络服务的具体内容由超越矿池根据实际情况提供。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("4.2除非您与超越矿池另有约定,您同意本服务仅为您个人非商业性质的使用。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("4.3超越矿池的部分服务是以收费方式提供的,如您使用收费服务,请遵守相关的协议。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "4.4超越矿池可能根据实际需要对收费服务的收费标准、方式进行修改和变更,超越矿池也可能会对部分免费服务开始收费。前述修改、变更或开始收费前,超越矿池将在相应服务页面进行通知或公告。如果您不同意上述修改、变更或付费内容,则应停止使用该服务。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "4.5超越矿池网络需要定期或不定期地对提供网络服务的平台或相关的设备进行检修或者维护,如因此类情况而造成网络服务(包括收费网络服务)在合理时间内的中断,超越矿池网络无需为此承担任何责任。超越矿池网络保留不经事先通知为维修保养、升级或其它目的暂停本服务任何部分的权利。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "4.6本服务或第三人可提供与其它国际互联网上之网站或资源之链接。由于超越矿池网络无法控制这些网站及资源,您了解并同意,此类网站或资源是否可供利用,超越矿池网络不予负责,存在或源于此类网站或资源之任何内容、广告、产品或其它资料,超越矿池网络亦不予保证或负责。因使用或依赖任何此类网站或资源发布的或经由此类网站或资源获得的任何内容、商品或服务所产生的任何损害或损失,超越矿池网络不承担任何责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("4.7超越矿池网络对在服务网上得到的任何商品购物服务、交易进程、招聘信息,都不作担保。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "4.8超越矿池网络有权于任何时间暂时或永久修改或终止本服务(或其任何部分) ,而无论其通知与否,超越矿池对用户和任何第三人均无需承担任何责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("4.9终止服务")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "您同意超越矿池得基于其自行之考虑,因任何理由,包含但不限于超越矿池认为您已经违反本服务协议的文字及精神,终止您的密码、帐号或本服务之使用(或服务之任何部分) ,并将您在本服务内任何内容加以移除并删除。您同意依本服务协议任何规定提供之本服务,无需进行事先通知即可中断或终止,您承认并同意,超越矿池可立即关闭或删除您的帐号及您帐号中所有相关信息及文件,或禁止继续使用前述文件或本服务。此外,您同意若本服务之使用被中断或终止或您的帐号及相关信息和文件被关闭或删除,超越矿池对您或任何第三人均不承担任何责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("五、质保内容和售后")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("5.1本云存储是用于投资的产品,投资需谨慎。本产品质保和售后服务政策如下,一旦订购,即视为对本政策的认同。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("5.2主网上线时间和生产周期等因素,无论是否按期发货,付款后均不能退款、退货;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("5.3本设备属于订购的IT云服务产品,产品有效期为一年,自主网上线之日起;")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("5.4由于市场波动,在您购买后,产品价格可能会调整。我们不承担事先通知、价格补偿的义务。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("5.5 IPFS-Filecoin主网上线后,本公司技术需确保云设备的部署和正常运行存储相关数据。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "5.6乙方对自己订购的数据存储节点所存储的数据每天所得的相关token奖励有知情权,甲方有义务采取APP(不限于此方法)等技术手段,令乙方知晓。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "5.7 PFS-Filecoin主网上线后,在IPFS官网官网规定的相关数据下,甲方保证部署的云设备可以正常存储相关数据后,并按官方公布的数据获取应有的token奖励,并把获取的相关token奖励按照约定比例,按合同要求转入乙方指定的公钥地址中。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "5.8 IPFS-Filecoin主网上线后,如甲方部署云设备无法正常运行并读取数据,并不能获取官方公布的标准获取相关token奖励,甲方有义务赔偿乙方所购云服务金额。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("六、争议解决与不可抗力")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text(
                  "6.1本条所称“不可抗力”是指不能预见、不能避免或不能克服的客观事件,包括但不限于自然灾害如洪水、火灾、爆炸、雷电、地震和风暴等以及社会事件如战争、动乱、政府管制、国家政策的突然变动和罢工等。如出现不可抗力导致的服务终止，超越矿池不用承认任何责任。")),
          Container(alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Text("6.2凡是因本合同引起的或与本合同有关的,双方无法协商解决的任何争议,均应提交当地仲裁院仲裁。争仪双方应该各自承担本方的仲裁费用和律师费。")),
        ]),
      ),
    );
  }
}
