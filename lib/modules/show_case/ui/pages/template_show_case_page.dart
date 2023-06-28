import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../ui/widgets/responsive/my_app_scaffold_widget.dart';
import '../../blocs/show_case_bloc.dart';
import '../../blocs/template_show_case_model_bloc.dart';
import '../../models/code_artifact_model.dart';
import '../../models/show_case_model.dart';
import '../../models/variant_artifact_model.dart';
import '../widgets/code_list.dart';

class TemplateShowCase extends StatelessWidget {
  const TemplateShowCase({
    required this.showCaseBloc,
    required this.templateShowCaseBloc,
    super.key,
  });
  final ShowCaseBloc showCaseBloc;
  final TemplateShowCaseBloc templateShowCaseBloc;

  @override
  Widget build(BuildContext context) {
    final ShowCaseModel showCaseModel = showCaseBloc.showCaseModelActive;
    final Color color = Theme.of(context).colorScheme.onPrimaryContainer;
    final String? urlImageDrive =
        showCaseBloc.parseUrlValidFromDrive(showCaseModel.artifact.image);
    const String imageDefault =
        'https://cdn-icons-png.flaticon.com/256/3342/3342137.png';
    final String title = showCaseModel.artifact.type;
    final TextStyle textStyleParagraphs = TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    final TextStyle textStyleHeadings = TextStyle(
      color: color,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    );
    return MyAppScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text(
              title != '' ? title[0].toUpperCase() + title.substring(1) : '',
              style: TextStyle(
                fontSize: 46,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              showCaseModel.artifact.description,
              style: textStyleParagraphs,
            ),
            Text(
              'Demo',
              style: textStyleHeadings,
            ),
            CodeWidget(
              templateShowCaseBloc: templateShowCaseBloc,
              imageDefault: imageDefault,
              image: urlImageDrive,
              codes: showCaseModel.codeArtifact,
              showCaseBloc: showCaseBloc,
            ),
            const SizedBox(height: 15.0),
            Text(
              'Uso',
              style: textStyleHeadings,
            ),
            Text(
              showCaseModel.useArtifactModel.description,
              style: textStyleParagraphs,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: CardUseWidget(
                    type: 'recomendation',
                    image: showCaseModel.useArtifactModel.recomendationImage,
                  ),
                ),
                Expanded(
                  child: CardUseWidget(
                    type: 'avoid',
                    image: showCaseModel.useArtifactModel.avoidDescription,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Recomendación',
                        style: textStyleParagraphs.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        showCaseModel.useArtifactModel.recomendationDescription,
                        style: textStyleParagraphs,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Evitar',
                        style: textStyleParagraphs.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        showCaseModel.useArtifactModel.avoidDescription,
                        style: textStyleParagraphs,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Anatomía',
              style: textStyleHeadings,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                height: 300,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 100,
                  ), /* CachedNetworkImage(
                    imageUrl: showCaseModel.artifact.anatomyImage,
                  ), */
                ),
              ),
            ),
            Text(
              'Variantes',
              style: textStyleHeadings,
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: showCaseModel.varianstArtifactModel.length,
                itemBuilder: (BuildContext context, int index) {
                  final VariantArtifactModel variantArtifactModel =
                      showCaseModel.varianstArtifactModel[index];
                  return Column(
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          text: '${variantArtifactModel.name} ',
                          style: textStyleParagraphs.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          children: <InlineSpan>[
                            TextSpan(
                              text: variantArtifactModel.description,
                              style: textStyleParagraphs,
                            )
                          ],
                        ),
                      ),
                      CodeWidget(
                        templateShowCaseBloc: templateShowCaseBloc,
                        imageDefault: imageDefault,
                        showCaseBloc: showCaseBloc,
                        codes: variantArtifactModel.codes,
                        image: showCaseBloc
                            .parseUrlValidFromDrive(variantArtifactModel.image),
                      )
                    ],
                  );
                },
              ),
            ),

            /*const PropertyHeader(),
            PropertiesList(
              properties: showCaseModel.propertiesArtifact,
              showCaseBloc: showCaseBloc,
            ),*/
          ],
        ),
      ),
    );
  }
}

class CardUseWidget extends StatelessWidget {
  const CardUseWidget({
    required this.image,
    required this.type,
    super.key,
  });

  final String image;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(
                color:
                    type == 'recomendation' ? Colors.green[400]! : Colors.red,
              ),
            ),
            child: const SizedBox(
              width: 300,
              height: 200,
              child: Center(
                  // child: NetworkImage(
                  //   image,
                  // ),
                  ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            backgroundColor:
                type == 'recomendation' ? Colors.green[400]! : Colors.red,
            child: Icon(
              type == 'recomendation' ? Icons.check_sharp : Icons.clear,
            ),
          ),
        ),
      ],
    );
  }
}

class CodeWidget extends StatelessWidget {
  const CodeWidget({
    required this.templateShowCaseBloc,
    required this.imageDefault,
    required this.showCaseBloc,
    required this.codes,
    super.key,
    this.image,
  });

  final TemplateShowCaseBloc templateShowCaseBloc;
  final String imageDefault;
  final List<CodeArtifactModel> codes;
  final ShowCaseBloc showCaseBloc;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: templateShowCaseBloc.showCodeArtifactStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> data) {
        final bool showCode = templateShowCaseBloc.showCodeArtifact;
        return Column(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: !showCode
                    ? const BorderRadius.all(
                        Radius.circular(25),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
              ),
              child: SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CachedNetworkImage(
                        width: 100,
                        height: 100,
                        imageUrl: image ?? imageDefault,
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        templateShowCaseBloc.switchShowCodeArtifact();
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Ver código',
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (showCode)
              CodeList(
                codes: codes,
                showCaseBloc: showCaseBloc,
              )
          ],
        );
      },
    );
  }
}
