import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/controllers/more_page_controlller.dart';
import 'package:remittance_app/feature/dashboard/widget/more/profile_picture.dart';
import 'package:remittance_app/feature/dashboard/widget/more/signout_bottom_sheet.dart';

class MorePage extends StatelessWidget {
  final _controller = Get.put<MorePageController>(getIt());

  final void Function() onNavigateToEditProfile;

  MorePage(this.onNavigateToEditProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        toolbarHeight: 1,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          ProfileHeader(_controller, onNavigateToEditProfile),
          Divider(
            thickness: 1,
            height: 4,
            color: (Theme.of(context).primaryColor as MaterialColor).shade700,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: _controller.navigateToIdentity,
                      leading: SvgPicture.asset(
                        AssetImages.userDetails,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'identity'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: SvgPicture.asset(
                        AssetImages.bankIcon2,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'manage_beneficiary'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: SvgPicture.asset(
                        AssetImages.identityCard,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'kyc_details'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      onTap: _controller.navigateToSettingPage,
                      leading: SvgPicture.asset(
                        AssetImages.phoneWithLock,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'settings'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: SvgPicture.asset(
                        AssetImages.aboutUs,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'about_us'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      leading: SvgPicture.asset(
                        AssetImages.termsAndCon,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'terms_and_conditions'.tr,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      onTap: () => Get.bottomSheet(
                        SignoutBottomSheet(onTap: _controller.signout),
                      ),
                      leading: SvgPicture.asset(
                        AssetImages.signout,
                        height: 28,
                        width: 28,
                      ),
                      title: Text(
                        'sign_out'.tr,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Color(0xFFE14F47),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final void Function() onNavigateToEditProfile;

  ProfileHeader(this.controller, this.onNavigateToEditProfile);

  final MorePageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ProfilePicture(
                      imagePath: controller.user.profileImage,
                      size: 70,
                      borderColor: Theme.of(context).primaryColor,
                      iconColor: Theme.of(context).primaryColor,
                    ),
                    _editProfileButton(context),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.user.firstName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 8),
                  Text(controller.user.email),
                  SizedBox(height: 8),
                  Text(controller.user.phoneNumber)
                ],
              )
            ],
          ),
          Text(
            'customer_id:'
                .trParams({'customerId': controller.user.phoneNumber}),
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _editProfileButton(BuildContext context) {
    return InkWell(
      onTap: onNavigateToEditProfile,
      //controller.navigateToEditProfile,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'edit_profile'.tr.toUpperCase(),
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: Color(0xFFE14F47),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
