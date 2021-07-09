import 'package:coordenador/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InputFile extends StatelessWidget {
  final String label;
  final VoidCallback selectLocalFile;
  final String selectedLocalFileName;
  final VoidCallback uploadingFile;
  final double percentageOfUpload;
  final String urlForDownload;
  const InputFile({
    Key? key,
    required this.label,
    required this.selectLocalFile,
    required this.selectedLocalFileName,
    required this.uploadingFile,
    required this.percentageOfUpload,
    required this.urlForDownload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          Text(label),
          ListTile(
            leading: Icon(Icons.attach_file),
            title: Text('1º Selecione o arquivo'),
            subtitle: Text(selectedLocalFileName),
            onTap: selectLocalFile,
          ),
          ListTile(
            leading: Icon(Icons.cloud_upload_outlined),
            title: Text('2º Envie para a núvem'),
            subtitle:
                urlForDownload.isNotEmpty ? Text('Envio finalizado') : Text(''),
            onTap: uploadingFile,
            trailing: Text('${percentageOfUpload.toStringAsFixed(2)}'),
          ),
          ListTile(
            leading: Icon(Icons.link),
            title: Text('3º Confira o arquivo em núvem'),
            subtitle: Text(urlForDownload),
            onTap: () async {
              if (urlForDownload.isNotEmpty) {
                bool can = await canLaunch(urlForDownload);
                if (can) {
                  await launch(urlForDownload);
                }
              }
            },
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.stroke,
          ),
        ],
      ),
    );
  }
}
