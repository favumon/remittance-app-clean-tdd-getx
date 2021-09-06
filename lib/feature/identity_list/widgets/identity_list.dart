import 'package:domain/feature/identity_list/entities/identity_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/identity_list/widgets/add_new_id_button.dart';
import 'package:remittance_app/feature/identity_list/widgets/id_list_item_label.dart';

class IdentityList extends StatelessWidget {
  final List<IdentityDetails> identities;

  const IdentityList(this.identities);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(height: 10),
          Align(alignment: Alignment.centerRight, child: AddNewIdButton()),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: identities.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black38,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IdListItemLabel('${'id_type'.tr}:',
                                    identities[index].idType),
                                SizedBox(
                                  height: 10,
                                ),
                                IdListItemLabel('${'id_number'.tr}:',
                                    identities[index].idNumber),
                                SizedBox(
                                  height: 10,
                                ),
                                IdListItemLabel('${'id_expiry'.tr}:',
                                    identities[index].expiryDateFormatted),
                                SizedBox(
                                  height: 10,
                                ),
                                IdListItemLabel('${'nationality'.tr}:',
                                    identities[index].nationality),
                              ],
                            )),
                            SizedBox(
                              height: 120,
                              child: Image.network(
                                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=250&w=760'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'signature'.tr,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 90,
                                    child: Image.network(
                                        identities[index].signatureUrl))
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
