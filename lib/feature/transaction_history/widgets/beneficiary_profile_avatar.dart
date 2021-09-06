import 'package:flutter/material.dart';

class BeneFiciaryProfileAvatar extends StatelessWidget {
  const BeneFiciaryProfileAvatar(this.url, this.shortName, {Key? key})
      : super(key: key);

  final String url;
  final String shortName;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 60,
        width: 60,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) => progress != null
                ? Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : child,
            errorBuilder: (ctx, _, __) => FittedBox(
              child: Text(
                shortName,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
