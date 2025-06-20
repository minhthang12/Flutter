import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/components/list_tile/divider_list_tile.dart';
import 'package:shop/components/network_image_with_loader.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/customer.dart';
import 'package:shop/route/screen_export.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/tokenStorage/token_storage.dart';

import 'components/profile_card.dart';
import 'components/profile_menu_item_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Customer? customer;
  @override
  void initState() {
    super.initState();
    loadCustomer();
  }

  void loadCustomer() async {
    final result = await ApiService.getCustomer();
    print('Customer loaded: ${result}');

    setState(() {
      customer = result;
    });
    print(customer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileCard(
            name: customer == null ? "" : customer!.name,
            email: customer == null ? "" : customer!.email,
            // imageSrc: "https://i.imgur.com/IXnwbLk.png",
            // proLableText: "Sliver",
            // isPro: true, if the user is pro
            press: () {
              Navigator.pushNamed(context, userInfoScreenRoute);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              "Tài khoản",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ProfileMenuListTile(
            text: "Đơn hàng",
            svgSrc: "assets/icons/Order.svg",
            press: () {
              Navigator.pushNamed(context, ordersScreenRoute);
            },
          ),
          // ProfileMenuListTile(
          //   text: "Danh sách yêu thích",
          //   svgSrc: "assets/icons/Wishlist.svg",
          //   press: () {},
          // ),
          // ProfileMenuListTile(
          //   text: "Addresses",
          //   svgSrc: "assets/icons/Address.svg",
          //   press: () {
          //     Navigator.pushNamed(context, addressesScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Payment",
          //   svgSrc: "assets/icons/card.svg",
          //   press: () {
          //     Navigator.pushNamed(context, emptyPaymentScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Wallet",
          //   svgSrc: "assets/icons/Wallet.svg",
          //   press: () {
          //     Navigator.pushNamed(context, walletScreenRoute);
          //   },
          // ),

          // const SizedBox(height: defaultPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: defaultPadding, vertical: defaultPadding / 2),
          //   child: Text(
          //     "Settings",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          // ProfileMenuListTile(
          //   text: "Language",
          //   svgSrc: "assets/icons/Language.svg",
          //   press: () {
          //     Navigator.pushNamed(context, selectLanguageScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "Location",
          //   svgSrc: "assets/icons/Location.svg",
          //   press: () {},
          // ),
          // const SizedBox(height: defaultPadding),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: defaultPadding, vertical: defaultPadding / 2),
          //   child: Text(
          //     "Help & Support",
          //     style: Theme.of(context).textTheme.titleSmall,
          //   ),
          // ),
          // ProfileMenuListTile(
          //   text: "Get Help",
          //   svgSrc: "assets/icons/Help.svg",
          //   press: () {
          //     Navigator.pushNamed(context, getHelpScreenRoute);
          //   },
          // ),
          // ProfileMenuListTile(
          //   text: "FAQ",
          //   svgSrc: "assets/icons/FAQ.svg",
          //   press: () {},
          //   isShowDivider: false,
          // ),
          const SizedBox(height: defaultPadding),

          // Log Out
          ListTile(
            onTap: () async {
              await TokenStorage.clearToken();
              Navigator.pushNamed(context, logInScreenRoute);
            },
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              "assets/icons/Logout.svg",
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                errorColor,
                BlendMode.srcIn,
              ),
            ),
            title: const Text(
              "Đăng xuất",
              style: TextStyle(color: errorColor, fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}
