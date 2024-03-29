import 'package:flutter/material.dart';

import 'package:coordenador/resource/controller/resource_model.dart';
import 'package:coordenador/theme/app_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceTile extends StatelessWidget {
  final ResourceModel? resourceModel;

  const ResourceTile({
    Key? key,
    required this.resourceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return resourceModel != null
        ? ListTile(
            leading:
                resourceModel?.url != null && resourceModel!.url!.isNotEmpty
                    ? Icon(AppIconData.linkOn)
                    : Icon(AppIconData.linkOff),
            trailing: IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/youtube',
                );
                //   },
              },
            ),
            title: Text('${resourceModel!.title}'),
            subtitle: Text(
                '${resourceModel!.description}\nresourceId: ${resourceModel!.id}'),
            onTap: resourceModel?.url != null && resourceModel!.url!.isNotEmpty
                ? () async {
                    bool can = await canLaunch(resourceModel!.url!);
                    if (can) {
                      await launch(resourceModel!.url!);
                    }
                  }
                : null,
          )
        : ListTile(
            leading: Icon(
              AppIconData.undefined,
            ),
            title: Text('Recurso não disponivel'),
          );
  }
}
