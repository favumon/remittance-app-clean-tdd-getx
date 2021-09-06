import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TransactionHistoryFilter extends StatefulWidget {
  TransactionHistoryFilter({
    Key? key,
    required this.changeFilterList,
    required this.selectedFilterList,
    required this.filterList,
  }) : super(key: key);

  final void Function(TransactionPaymentModeFilter?) changeFilterList;
  final List<TransactionPaymentModeFilter> selectedFilterList;
  final List<TransactionPaymentModeFilter> filterList;

  @override
  _TransactionHistoryFilterState createState() =>
      _TransactionHistoryFilterState();
}

class _TransactionHistoryFilterState extends State<TransactionHistoryFilter> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (expanded)
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(right: 50),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => widget.changeFilterList(null),
                    child: Text(
                      'clear_all'.tr,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.filterList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Obx(
                          () => InkWell(
                            onTap: () {
                              widget.changeFilterList(widget.filterList[index]);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                  color: widget.selectedFilterList
                                          .contains(widget.filterList[index])
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.8)
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  widget.filterList[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: widget.selectedFilterList
                                                  .contains(
                                                      widget.filterList[index])
                                              ? Colors.white
                                              : Colors.black87),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                icon: Icon(expanded ? Icons.close : Icons.tune),
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
