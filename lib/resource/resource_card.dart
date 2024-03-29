import 'package:coordenador/resource/controller/resource_model.dart';
import 'package:coordenador/resource/resource_tile.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceCard extends StatelessWidget {
  final ResourceModel resourceModel;

  const ResourceCard({
    Key? key,
    required this.resourceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ResourceTile(
            resourceModel: resourceModel,
          ),
          // ListTile(
          //   leading: resourceModel.url != null && resourceModel.url!.isNotEmpty
          //       ? Icon(AppIconData.linkOn)
          //       : Icon(AppIconData.linkOff),
          //   title: Text('${resourceModel.title}'),
          //   subtitle: Text('${resourceModel.description}'),
          //   onTap: resourceModel.url != null && resourceModel.url!.isNotEmpty
          //       ? () async {
          //           if (resourceModel.url != null) {
          //             bool can = await canLaunch(resourceModel.url!);
          //             if (can) {
          //               await launch(resourceModel.url!);
          //             }
          //           }
          //         }
          //       : null,
          // ),
        ],
      ),
    );
  }
}
