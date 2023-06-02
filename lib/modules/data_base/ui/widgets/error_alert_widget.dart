part of pragma_app.modules.data_base.iu.widgets;

class ErrorAlert extends StatelessWidget {
  const ErrorAlert(
      {super.key, required this.errorData, required this.onPressed});
  final Map<String, dynamic> errorData;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  errorData['icon'] as IconData,
                  size: 40,
                ),
                Flexible(
                  child: Text(
                    errorData['title'] as String,
                  ),
                ),
              ],
            ),
          ),
          Text(errorData['description'] as String),
          CustomFatButtonWidget(
            key: const Key('ErrorAlert_CustomFatButtonWidget_FailedAlert'),
            label: 'Aceptar',
            iconData: Icons.arrow_right_rounded,
            function: () => onPressed(),
          )
        ],
      ),
    );
  }
}
