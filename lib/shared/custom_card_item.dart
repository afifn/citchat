import 'package:citchat/shared/theme.dart';
import 'package:flutter/material.dart';

class MessageCardItem extends StatelessWidget {
  final double height;
  final double widht;
  final String photo;
  final String name;
  final String message;
  final bool isOnline;
  final String time;
  final VoidCallback? onPressed;

  const MessageCardItem({
    required this.name,
    required this.photo,
    required this.message,
    required this.time,
    this.isOnline = false,
    this.height = 80.0,
    this.widht = double.infinity,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: widht,
        height: height,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                  image: AssetImage(photo),
                )
              ),
              child: isOnline ? Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 14.0,
                  ),
                ),
              ) : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: monsterratTextStyle.copyWith(fontWeight: semiBold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: monsterratTextStyle.copyWith(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Text(time, style: monsterratTextStyle.copyWith(fontSize: 12, fontWeight: semiBold),),
          ],
        ),
      ),
    );
  }
}

class BubbleChatItem extends StatelessWidget {
  final bool isSender;
  final String photo;
  final String message;
  final bool hasImage;
  final String? image;
  final String time;

  const BubbleChatItem({
    super.key,
    required this.photo,
    this.isSender = true,
    this.hasImage = false,
    this.image,
    required this.message, required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final colorOnPrimary = Theme.of(context).colorScheme.onSecondary;
    final colorOnSecondary = Theme.of(context).colorScheme.tertiaryContainer;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isSender) Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (photo.isNotEmpty) ? NetworkImage(photo) : const AssetImage('assets/images/ava.jpg') as ImageProvider<Object>,
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(width: isSender ? 8 : 0),
          Flexible(
            child: Container(
              // width: 235,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSender ? colorOnPrimary : colorOnSecondary,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(14),
                  topLeft: const Radius.circular(14),
                  bottomLeft: Radius.circular(isSender ? 0 : 14),
                  bottomRight: Radius.circular(isSender ? 14 : 0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (hasImage) ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(image!, fit: BoxFit.cover,),
                  ),
                  if (hasImage) const SizedBox(height: 6,),
                  Text(
                    message,
                    style: monsterratTextStyle.copyWith(fontWeight: medium),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: monsterratTextStyle.copyWith(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: !isSender ? 8 : 0),
          if (!isSender) Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(photo),
                  fit: BoxFit.cover,
                )
            ),
          ),
        ],
      ),
    );
  }
}

class CardPeopleItem extends StatelessWidget {
  final String name;
  final String email;
  final String photo;
  final VoidCallback onPressed;

  const CardPeopleItem({
    Key? key,
    required this.name,
    required this.email,
    required this.photo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Center(
          child: Column(
            children: [
              if (photo.isNotEmpty)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (photo.isEmpty)
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/ava.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              const SizedBox(height: 8),
              Text(
                name,
                style: monsterratTextStyle.copyWith(fontWeight: semiBold, fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                email,
                style: monsterratTextStyle.copyWith(fontSize: 11),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
