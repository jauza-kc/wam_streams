import 'package:flutter/material.dart';

class TextListTileWithSubtitle extends StatelessWidget {
  TextListTileWithSubtitle({
    Key? key,
    this.title,
    this.subtitle1,
    this.subtitle2,
    this.height,
    this.onDelete,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);
  final void Function(BuildContext) onTap;
  void Function(BuildContext)? onDelete;
  final double defaultHeight = 75;
  final double? height;
  final String? title;
  final String? subtitle1;
  final String? subtitle2;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Container(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: isFirst ? BorderSide(width: 0.5, color: Theme.of(context).dividerColor) : BorderSide.none,
              bottom: isLast ? BorderSide(width: 1, color: Theme.of(context).dividerColor) : BorderSide.none,
            )),
            height: height ?? defaultHeight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 9.5, 20, 12.5),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(title ?? "",
                            style: TextStyle(fontSize: 14, color: Colors.black, overflow: TextOverflow.ellipsis)),
                        if (subtitle1 != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle1 ?? "",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                        if (subtitle2 != null) ...[
                          const SizedBox(height: 1),
                          Text(subtitle2 ?? "", style: TextStyle(fontSize: 12, color: Colors.grey))
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
