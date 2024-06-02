import 'package:flutter/material.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/util/colors.dart';
import 'package:flutter_store/util/text_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FavoritedItemCard extends StatefulWidget {
  final Function onClickRemoveFavorite;
  final Function onClickAddShopBag;
  final Product product;

  const FavoritedItemCard(
      {super.key,
      required this.onClickRemoveFavorite,
      required this.onClickAddShopBag,
      required this.product});

  @override
  State<FavoritedItemCard> createState() => _FavoritedItemCardState();
}

class _FavoritedItemCardState extends State<FavoritedItemCard> {
  double opacityLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      widget.onClickRemoveFavorite();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.product.image!,
                  height: 100,
                  width: 100,
                ).paddingOnly(right: 10),
                Expanded(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                  
                  Text(NumberFormat.currency(
                    locale: 'pt_BR', 
                    symbol: 'R\$', 
                    decimalDigits: 2)
                .format(widget.product.price))
                    ],
                  ),
                )
              ],
            ),
            ElevatedButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(greenScoutCorrect)),
              onPressed: () {
                widget.onClickAddShopBag();
                widget.onClickRemoveFavorite();
              },
              child: Text('Add to bag', style: AppTextStyles.s10w400cWhite,),
            ).paddingOnly(top: 10),
          ],
        ),
      ),
    );
  }
}
