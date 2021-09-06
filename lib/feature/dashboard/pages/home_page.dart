import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/controllers/home_page_controller.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/dashboard/widget/bill_payment/bill_payment.dart';
import 'package:remittance_app/feature/dashboard/widget/esay_resend/easy_resend.dart';
import 'package:remittance_app/feature/dashboard/widget/notification/notification_count_widget.dart';
import 'package:remittance_app/feature/dashboard/widget/quick_link/quick_link.dart';
import 'package:remittance_app/feature/dashboard/widget/slider_advertisement/slider_advertisement.dart';
import 'package:remittance_app/feature/dashboard/widget/top_exchange_rate/top_exchange_rate.dart';
import 'package:remittance_app/feature/dashboard/widget/transaction_history/transaction_history_widget.dart';

class HomePage extends StatefulWidget {
  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  HomePage(this.onNavigateTransactionHistory);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double sidePaddingScreen = 0;

  final HomePageController _controller = Get.put<HomePageController>(getIt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: SearchHeader(
              icon: Icons.terrain,
              title: 'Remittance App',
              search: _Search(widget.onNavigateTransactionHistory),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: new Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [_mainContainerWidget()],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _mainContainerWidget() {
    double _paddingSize = MediaQuery.of(context).size.height * .001;
    return Padding(
      padding: EdgeInsets.only(top: _paddingSize),
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: sidePaddingScreen, right: sidePaddingScreen),
                child: _billPayment(),
              ),
              SliderAdvertisement(),
              Padding(
                padding: EdgeInsets.only(
                    top: 15, left: sidePaddingScreen, right: sidePaddingScreen),
                child: QuickLink(),
              ),
              Container(
                color: Color(0xFFF9F9F9),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 5,
                      top: 15,
                      left: sidePaddingScreen,
                      right: sidePaddingScreen),
                  child: EasyResendWidget(),
                ),
              ),
              SizedBox(height: 10)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _billPayment() {
    double _containerSendMoneySize = MediaQuery.of(context).size.width * .44;
    double _paddigSizeTop =
        MediaQuery.of(context).size.height * .23 - _containerSendMoneySize;
    return Padding(
      padding: EdgeInsets.only(top: _paddigSizeTop),
      child: Container(
          child: Column(
        children: [BillPaymentWidget()],
      )),
    );
  }
}

class _Search extends StatefulWidget {
  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  _Search(this.onNavigateTransactionHistory);
  @override
  __SearchState createState() => __SearchState();
}

class __SearchState extends State<_Search> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: _sendMoneyContainer(),
            ),
          ),
        ),
        Expanded(
          child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: TransactionHistoryContainer(
                  widget.onNavigateTransactionHistory),
            ),
          ),
        ),
      ],
    );

    // return Padding(
    //   padding: const EdgeInsets.only(left: 0, right: 0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       // Expanded(
    //       //   child: TextField(
    //       //     controller: _editingController,
    //       //     // textAlignVertical: TextAlignVertical.center,
    //       //     onChanged: (_) => setState(() {}),
    //       //     decoration: InputDecoration(
    //       //       hintText: 'Search',
    //       //       hintStyle: TextStyle(
    //       //           color: Theme.of(context).primaryColor.withOpacity(0.5)),
    //       //       enabledBorder: InputBorder.none,
    //       //       focusedBorder: InputBorder.none,
    //       //     ),
    //       //   ),
    //       // ),
    //       // _editingController.text.trim().isEmpty
    //       //     ? IconButton(
    //       //         icon: Icon(Icons.search,
    //       //             color: Theme.of(context).primaryColor.withOpacity(0.5)),
    //       //         onPressed: null)
    //       //     : IconButton(
    //       //         highlightColor: Colors.transparent,
    //       //         splashColor: Colors.transparent,
    //       //         icon: Icon(Icons.clear,
    //       //             color: Theme.of(context).primaryColor.withOpacity(0.5)),
    //       //         onPressed: () => setState(
    //       //           () {
    //       //             _editingController.clear();
    //       //           },
    //       //         ),
    //       //       ),
    //       _sendMoneyContainer(),
    //       TransactionHistoryContainer(widget.onNavigateTransactionHistory)
    //     ],
    //   ),
    // );
  }

  Widget _transHistoryContainer() {
    double _paddigSize = MediaQuery.of(context).size.height * .28;
    double _paddingBelow = MediaQuery.of(context).size.width * .08;
    double _containerSendMoneySize = MediaQuery.of(context).size.width * .40;
    return Padding(
      padding: EdgeInsets.only(top: _paddigSize + _paddingBelow),
      child: Container(
        width: _containerSendMoneySize,
        height: _containerSendMoneySize,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: const Offset(5.0, 5.0),
              blurRadius: 5.0,
              spreadRadius: 1.0)
        ]),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {}, //_controller.navigateToTxnHistory,
                  child: Image.asset(
                    image.AssetImages.sendMoneyContainerBackgroundImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, bottom: 16, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .18,
                        height: MediaQuery.of(context).size.width * .18,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).primaryColor
                                    as MaterialColor)
                                .shade900),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * .045),
                          child: InkWell(
                            onTap: () {
                              // onNavigateToTransactionHistory(
                              //     TransactionHistoryNavigation
                              //         .transactionHistoryList);
                            }, //_controller.navigateToTxnHistory,
                            child: SvgPicture.asset(
                              image.AssetImages.dashTransactionHisIcon,
                              color: Colors.white,
                              alignment: Alignment.center,
                              clipBehavior: Clip.hardEdge,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'transaction_history_cap'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          // Obx(
                          //   () => _controller.busy.value
                          //       ? Container(
                          //           height: 10,
                          //           child: Center(
                          //             child:
                          //             //CommonLoader(),
                          //           ),
                          //         )
                          //       : Padding(
                          //           padding: const EdgeInsets.only(top: 3.0),
                          //           child: Row(
                          //             children: [
                          //               Text('Pending'.tr,
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.bold,
                          //                       fontSize: 12)),
                          //               Padding(
                          //                 padding:
                          //                     const EdgeInsets.only(left: 10.0),
                          //                 child: Container(
                          //                   width: 15,
                          //                   height: 15,
                          //                   alignment: Alignment.center,
                          //                   decoration: BoxDecoration(
                          //                       shape: BoxShape.circle,
                          //                       color: Colors.red),
                          //                   child: Text(
                          //                    "2",
                          //                    // _controller
                          //                         // .pendingTransactionCount
                          //                         // .toString()
                          //                     style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontSize: 10),
                          //                   ),
                          //                 ),
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _sendMoneyContainer() {
    double _paddigSizeTop = MediaQuery.of(context).size.height * .01;

    double _containerSendMoneySize = MediaQuery.of(context).size.width * .45;
    return Padding(
      padding: EdgeInsets.only(top: _paddigSizeTop),
      child: Container(
        width: _containerSendMoneySize,
        height: _containerSendMoneySize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38,
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.0)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
          child: Stack(
            children: [
              Image.asset(
                image.AssetImages.sendMoneyContainerBackgroundImage,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 16, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .2,
                      height: MediaQuery.of(context).size.width * .2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).primaryColor as MaterialColor)
                                  .shade900),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * .045),
                        child: SvgPicture.asset(
                          image.AssetImages.dashSendmoneyIcon,
                          alignment: Alignment.center,
                          clipBehavior: Clip.hardEdge,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'send'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('money'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchHeader extends SliverPersistentHeaderDelegate {
  final double minTopBarHeight = 200;
  final double maxTopBarHeight = 400;
  final String title;
  final IconData icon;
  final Widget search;

  SearchHeader({
    required this.title,
    required this.icon,
    required this.search,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    var shrinkFactor = min(1, shrinkOffset / (maxExtent - minExtent));

    var topBar = Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        height:
            max(maxTopBarHeight * (1 - shrinkFactor * 1.45), minTopBarHeight),
        width: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset(
              image.AssetImages.mainBackgroundDash,
              fit: BoxFit.fill,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.38,
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_profileData(), NotificationIconAndCount()],
                      ),
                      TopExchangeRate()
                    ]),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFF313865),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
      ),
    );
    return Container(
      height: max(maxExtent - shrinkOffset, minExtent),
      child: Stack(
        fit: StackFit.loose,
        children: [
          if (shrinkFactor <= 0.5) topBar,
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: Container(
                alignment: Alignment.center,
                child: search,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * .56,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20),
                        // color: Colors.redAccent,
                        boxShadow: [
                      // BoxShadow(
                      //   offset: Offset(0, 10),
                      //   blurRadius: 10,
                      //   color: Colors.green.withOpacity(0.23),
                      // )
                    ]),
              ),
            ),
          ),
          if (shrinkFactor > 0.5) topBar,
        ],
      ),
    );
  }

  Widget _profileData() {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1)),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'welcome_back'.tr,
                style: TextStyle(color: Color(0xFFF9F9F9), fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Adam John',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 500;

  @override
  double get minExtent => 200;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
