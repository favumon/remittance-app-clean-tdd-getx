import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/feature/dashboard/pages/contact_page.dart';
import 'package:remittance_app/feature/dashboard/pages/faq_page.dart';
import 'package:remittance_app/feature/dashboard/pages/home_page.dart';
import 'package:remittance_app/feature/dashboard/pages/more_page.dart';
import 'package:remittance_app/feature/edit_profile/pages/edit_profile_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/pending_transaction_details_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/recent_transaction_details_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/transaction_history_page.dart';

enum TransactionHistoryNavigation {
  transactionHistoryList,
  recenttransactionDetail,
  pendingTransactionDetail
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool isOnEditProfile = false;
  TransactionHistoryNavigation? transactionHistoryNavigation;
  Color _getBgColor(int index) =>
      _selectedIndex == index ? Color(0xFFFDF1ED) : Colors.white;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _itemIconBottomNavigationBar(
          int index, String iconPath, String label) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Container(
          width: double.infinity,
          height: kBottomNavigationBarHeight,
          decoration: BoxDecoration(
              color: _getBgColor(index),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    color: Color(0xFF505054),
                    width: 20,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      label,
                      style: TextStyle(
                          color: Color(0xFF505054),
                          fontSize: 10,
                          fontWeight: FontWeight.w900),
                    ),
                  )
                ]),
          ),
        ),
      );

  Widget getHomePage(
      TransactionHistoryNavigation? transactionHistoryNavigation) {
    if (transactionHistoryNavigation == null)
      return HomePage(onNavigateTransactionHistory);
    switch (transactionHistoryNavigation) {
      case TransactionHistoryNavigation.transactionHistoryList:
        return TransactionHistoryPage(
            onNavigateTransactionHistory, transactionHistoryTabIndex);
      case TransactionHistoryNavigation.recenttransactionDetail:
        return RecentTransactionDetailsPage(onNavigateTransactionHistory);
      case TransactionHistoryNavigation.pendingTransactionDetail:
        return PendingTransactionDetailsPage(onNavigateTransactionHistory);
      default:
        return Container();
    }
  }

// widget body page
  get _pageSelectionWidgets => <Widget>[
        getHomePage(transactionHistoryNavigation),
        FaqPage(),
        ContactPage(),
        isOnEditProfile
            ? EditProfilePage(onNavigateBackFromEditProfile)
            : MorePage(onNavigateToEditProfile)
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageSelectionWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 15,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.amberAccent,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _itemIconBottomNavigationBar(
                  0, image.AssetImages.homeDashboardIcon, 'Home'),
              title: SizedBox.shrink()
              //  label: 'Home'
              ),
          BottomNavigationBarItem(
            icon: _itemIconBottomNavigationBar(
                1, image.AssetImages.faqDashboardIcon, 'FAQ'),
            title: SizedBox.shrink(),
            // label: ''
          ),
          BottomNavigationBarItem(
              icon: _itemIconBottomNavigationBar(
                  2, image.AssetImages.contactDashboardIcon, 'Contact'),
              title: SizedBox.shrink()),
          BottomNavigationBarItem(
              icon: _itemIconBottomNavigationBar(
                  3, image.AssetImages.moreDashboardIcon, 'More'),
              title: SizedBox.shrink())
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  int transactionHistoryTabIndex = 0;

  void onNavigateToEditProfile() {
    setState(() {
      isOnEditProfile = true;
    });
  }

  void onNavigateTransactionHistory(
      TransactionHistoryNavigation? transactionHistoryNavigation) {
    setState(() {
      if (transactionHistoryNavigation ==
          TransactionHistoryNavigation.transactionHistoryList)
        transactionHistoryTabIndex = this.transactionHistoryNavigation ==
                TransactionHistoryNavigation.pendingTransactionDetail
            ? 1
            : 0;
      this.transactionHistoryNavigation = transactionHistoryNavigation;
    });
  }

  void onNavigateBackFromEditProfile() {
    setState(() {
      isOnEditProfile = false;
    });
  }
}
