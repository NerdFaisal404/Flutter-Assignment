import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/utils/colors.dart';

class RichAlertDialog extends StatefulWidget {
  /// The title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Usually has a bigger fontSize than the [alertSubtitle].
  final Text alertTitle;

  /// The subtitle of the dialog is displayed in a medium-sized font beneath
  /// the title of the dialog.
  ///
  /// Usually has a smaller fontSize than the [alertTitle]
  final Text alertSubtitle;

  /// The type of dialog, whether warning, success or error.
  final int alertType;

  /// The (optional) actions to be performed in the dialog is displayed
  /// the subtitle of the dialog. If no values are provided, a default
  /// [Button] widget is rendered.
  ///
  /// Typically a [List<Widget>] widget.
  final List<Widget> actions;

  /// Specifies how blur the screen overlay effect should be.
  /// Higher values mean more blurred overlays.
  final double blurValue;

  // Specifies the opacity of the screen overlay
  final double backgroundOpacity;

  /// (Optional) User defined icon for the dialog. Advisable to use the
  /// default icon matching the dialog type.
  final Icon dialogIcon;

  RichAlertDialog({
    Key key,
    @required this.alertTitle,
    @required this.alertSubtitle,
    @required this.alertType,
    this.actions,
    this.blurValue,
    this.backgroundOpacity,
    this.dialogIcon,
  }) : super(key: key);

  createState() => _RichAlertDialogState();
}

class _RichAlertDialogState extends State<RichAlertDialog> {
  Map<int, AssetImage> _typeAsset = {
    RichAlertType.ERROR: AssetImage("images/error.png"),
    RichAlertType.SUCCESS: AssetImage("images/success.png"),
    RichAlertType.WARNING: AssetImage("images/warning.png"),
    RichAlertType.CUSTOM: AssetImage("images/warning.png"),
    RichAlertType.INFO: AssetImage("images/info.png"),
  };

  Map<int, Color> _typeColor = {
    RichAlertType.ERROR: Colors.red,
    RichAlertType.SUCCESS: Colors.green,
    RichAlertType.WARNING: Colors.orange,
    RichAlertType.INFO: Colors.blue,
  };

  double deviceWidth;
  double deviceHeight;
  double dialogHeight;
  double dialogHeight1;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Size screenSize = MediaQuery.of(context).size;

    deviceWidth = orientation == Orientation.portrait
        ? screenSize.width
        : screenSize.height;
    deviceHeight = orientation == Orientation.portrait
        ? screenSize.height
        : screenSize.width;
    dialogHeight = deviceHeight * (0.50);

    dialogHeight1 = 200;

    return MediaQuery(
      data: MediaQueryData(),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: widget.blurValue != null ? widget.blurValue : 3.0,
          sigmaY: widget.blurValue != null ? widget.blurValue : 3.0,
        ),
        child: Container(
          height: dialogHeight,
          color: Colors.white.withOpacity(widget.backgroundOpacity != null
              ? widget.backgroundOpacity
              : 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      bottom: dialogHeight - 70,
                      child: Container(
                        height: dialogHeight1,
                        width: deviceWidth * 0.9,
                        child: Card(
                          color: Color(0XFF5F6368),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 10),
                              widget.dialogIcon != null
                                  ? widget.dialogIcon
                                  : _defaultIcon(),
                              SizedBox(height: 10),
                              widget.alertTitle,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: widget.alertSubtitle,
                              ),
                              widget.actions != null &&
                                      widget.actions.isNotEmpty
                                  ? _buildActions()
                                  : _defaultAction(context),
                            ],
                          ),
                        ),
                      ),
                    ),
//                    Positioned(
//                      bottom: dialogHeight - 50,
//                      child: widget.dialogIcon != null
//                          ? widget.dialogIcon
//                          : _defaultIcon(),
//                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildActions() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.actions,
      ),
    );
  }

  Image _defaultIcon() {
    return Image(
      image: _typeAsset[widget.alertType],
      width: deviceHeight / 20,
      height: deviceHeight / 20,
    );
  }

  Container _defaultAction(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        elevation: 2.0,
        color: _typeColor[widget.alertType],
        child: Text(
          "GOT IT",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Text richTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 18.0),
  );
}

Text richSubtitle(String subtitle) {
  return Text(
    subtitle,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: 16.0,
    ),
  );
}

class RichAlertType {
  /// Indicates an error dialog by providing an error icon.
  static const int ERROR = 0;

  /// Indicates a success dialog by providing a success icon.
  static const int SUCCESS = 1;

  /// Indicates a warning dialog by providing a warning icon.
  static const int WARNING = 2;

  /// Indicates a warning dialog by providing an info icon.
  static const int INFO = 4;

  /// Indicates a warning dialog by providing a custom icon.
  static const int CUSTOM = 5;
}
