import 'package:flutter_application_1/model/reaction_class.dart';

import '../index.dart';

class FBFullReaction extends StatefulWidget {
  const FBFullReaction({
    Key? key,
    required this.data,
    this.reloadState,
    this.comment,
    this.reloadReaction,
    this.updateState,
  }) : super(key: key);
  final Post data;
  final Function(Post)? reloadState;
  final Function(Post)? updateState;
  final Comment1? comment;
  final Function(Comment1)? reloadReaction;
  @override
  State<FBFullReaction> createState() => _FBFullReactionState();
}

class _FBFullReactionState extends State<FBFullReaction>
    with TickerProviderStateMixin {
  final double _reactSize = 32;
  final double _reactMargin = 2;
  final double _reactBarBotMargin = 44;
  final double _reactBarPadding = 4;
  Offset tapPosition = const Offset(0, 0);
  //resouce
  List<Map> _news = [];
  List<ButtonReaction> _reactions = [];
  final Map<String, Color> _reactColors = {
    "like": blue,
    "love": Colors.red,
    "haha": Colors.yellow,
    "wow": Colors.amber,
    "sad": Colors.amberAccent,
    "angry": Colors.deepOrange
  };

  //news selected
  int _newsSelected = -1;
  LongPressStartDetails _newsPosition = const LongPressStartDetails();
  late AnimationController _newsCtr;
  late Animation<double> _newsAni;

  //react selected
  int _reactSelected = -1;
  Path _reactPath = Path();
  Rect _reactRect = Rect.zero;
  late AnimationController _reactCtr;
  late Animation<double> _reactAni;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  double get reactSize => _reactSize + _reactMargin * 2;

  double get reactScale => 1.5;

  bool isLike = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initReactions();
    _initNews();
    var itemDuration = const Duration(milliseconds: 300);
    _newsCtr = AnimationController(vsync: this, duration: itemDuration);
    _newsAni = CurvedAnimation(parent: _newsCtr, curve: Curves.fastOutSlowIn);
    var reactDuration = const Duration(milliseconds: 1000);
    _reactCtr = AnimationController(vsync: this, duration: reactDuration);
    _reactAni = CurvedAnimation(parent: _reactCtr, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    for (var element in _reactions) {
      element.controller.dispose();
    }
    _reactCtr.dispose();
    _newsCtr.dispose();
    super.dispose();
  }

  ///////OVERLAY
  OverlayEntry? overlayEntry;

  void removeOverlay() {
    //function
    overlayEntry?.remove();
    overlayEntry = null;
  }

  createReactArea(BuildContext context) {
    //function
    var globalOrigin = _newsPosition.globalPosition;
    var localOrigin = _newsPosition.localPosition;

    var dy = globalOrigin.dy - localOrigin.dy - _reactBarBotMargin;
    dy = dy - _reactBarPadding;
    dy = dy - _reactMargin;
    double x = 10;
    tapPosition = Offset(x, dy);

    removeOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: tapPosition.dy - 30,
        left: tapPosition.dx,
        child: ScaleTransition(
          scale: _newsAni,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [_buildReactBar(), _buildAnimatedReactBar()],
          ),
        ),
      ),
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  _initReactions() {
    //init
    _reactions = List.generate(_reactColors.length, (index) {
      var duration = const Duration(milliseconds: 100);
      var ctrl = AnimationController(vsync: this, duration: duration);
      var ani = CurvedAnimation(parent: ctrl, curve: Curves.fastOutSlowIn);
      return ButtonReaction(_reactColors.keys.toList()[index],
          color: _reactColors.values.toList()[index],
          controller: ctrl,
          animation: ani);
    });
  }

  _initNews() {
    _news = List.generate(1, (index) {
      return {
        "reaction": null,
      };
    });
    // to set init value of button
  }

  _setIcon(int reaction) {
    //utils
    switch (reaction) {
      case 0:
        _news[0]["reaction"] = _reactions[0];
        isLike = true;
        break;
      case 1:
        _news[0]["reaction"] = _reactions[1];
        break;
      case 2:
        _news[0]["reaction"] = _reactions[2];
        break;
      case 3:
        _news[0]["reaction"] = _reactions[3];
        break;
      case 4:
        _news[0]["reaction"] = _reactions[4];
        break;
      case 5:
        _news[0]["reaction"] = _reactions[5];
        break;
    }
  }

  void _changeIcon(int reaction) {
    setState(() {
      isLike = false;
      switch (_reactSelected) {
        case 0:
          isLike = true;
          reaction = 0;
          break;
        case 1:
          reaction = 1;
          break;
        case 2:
          reaction = 2;
          break;
        case 3:
          reaction = 3;
          break;
        case 4:
          reaction = 4;
          break;
        case 5:
          reaction = 5;
          break;
      }
      if (widget.data.reactions.isNotEmpty) {
        if (widget.data.reactions[0].user.name == currUser!.name) {
          widget.data.reactions[0].reaction = reaction;
        }
      }
      if (widget.comment != null) {
        if (widget.comment!.reactions.isNotEmpty) {
          if (widget.comment!.reactions[0].user.name == currUser!.name) {
            widget.comment!.reactions[0].reaction = reaction;
          }
        }
      }
    });
  }

  Widget _buildReactAnimation() {
    //Emotes pathway
    return AnimatedBuilder(
        animation: _reactAni,
        builder: (context, _) {
          if (_reactPath.computeMetrics().isEmpty) {
            return const SizedBox();
          }
          var length = _reactPath.computeMetrics().first.length;
          var unit = length * _reactAni.value * 0.6;
          double opacity = _reactAni.value > 0.8 ? 0 : 1;
          double bigSize = _reactSize + _reactSize * reactScale;
          double size = bigSize - bigSize * 0.8 * _reactAni.value;
          var f = _reactPath.computeMetrics().first;
          var p = f.extractPath(unit, unit);
          return Positioned(
              top: p.getBounds().center.dy - size / 2,
              left: p.getBounds().center.dx - size / 2,
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 200),
                child: _reactSelected == -1
                    ? const SizedBox()
                    : Image.asset(_reactions[_reactSelected].gif,
                        height: size, width: size),
              ));
        });
  }

  Widget _buildItem(BuildContext context, int index) {
    return Column(
      // alignment: Alignment.bottomCenter,
      children: [
        _buildNewItem(context, index),
      ],
    );
  }

  _buildReactBar() {
    var circular = (reactSize + _reactBarPadding) / 2;
    var radius = BorderRadius.circular(circular);
    var shadow = const [
      BoxShadow(
          offset: Offset(5, 5),
          color: Colors.black38,
          blurRadius: 24,
          spreadRadius: -12)
    ];

    return Transform.translate(
      offset: const Offset(0, 22),
      child: Container(
        margin: EdgeInsets.only(bottom: _reactBarBotMargin),
        padding: EdgeInsets.all(_reactBarPadding),
        decoration: BoxDecoration(
          borderRadius: radius,
          color: Colors.white,
          boxShadow: shadow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_reactions.length, (index) {
              return Padding(
                padding: EdgeInsets.all(_reactMargin),
                child: AnimatedBuilder(
                    animation: _reactions[index].animation,
                    builder: (context, _) {
                      double scale =
                          reactScale * _reactions[index].animation.value;
                      double bigSize = _reactSize + _reactSize * scale;
                      return SizedBox(height: _reactSize, width: bigSize);
                    }),
              );
            }),
          ),
        ),
      ),
    );
  }

  _buildAnimatedReactBar() {
    return Container(
      padding: EdgeInsets.all(_reactBarPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_reactions.length, (index) {
          return Padding(
            padding: EdgeInsets.all(_reactMargin),
            child: AnimatedBuilder(
                animation: _reactions[index].animation,
                builder: (context, _) {
                  var gif = _reactions[index].gif;
                  var text = _reactions[index].text;
                  double animation = _reactions[index].animation.value;
                  double scale = reactScale * animation;
                  double bigSize = _reactSize + _reactSize * scale;
                  return Transform.translate(
                    offset: Offset(0, bigSize > 32 ? -50 : 0),
                    child: Column(
                      children: [
                        ScaleTransition(
                            scale: _reactions[index].animation,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Material(
                                color: Colors.black54,
                                shape: const StadiumBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  child: Text(
                                    text,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                            )),
                        Image.asset(gif, width: bigSize, height: bigSize),
                      ],
                    ),
                  );
                }),
          );
        }),
      ),
    );
  }

  _buildNewItem(BuildContext context, int index) {
    return Column(
      children: [
        _buildLikeButton(context, index),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context, int index) {
    ButtonReaction? reaction = _news[index]["reaction"];
    String text = "Like";
    Color textColor = Colors.grey;
    if (widget.reloadState == null) {
      textColor = const Color.fromARGB(255, 109, 107, 107);
    }

    if (widget.data.reactions.isNotEmpty) {
      if (widget.data.reactions[0].user.name == currUser!.name) {
        if (widget.data.reactions[0].reaction == 1) {
          isLike = true;
        } else {
          isLike = false;
        }
      } else {
        isLike = false;
      }
    }
    if (widget.comment != null) {
      if (widget.comment!.reactions.isNotEmpty) {
        if (widget.comment!.reactions[0].user.name == currUser!.name) {
          if (widget.comment!.reactions[0].reaction == 1) {
            isLike = true;
          } else {
            isLike = false;
          }
        } else {
          isLike = false;
        }
      }
    }
    if (reaction != null) {
      textColor = reaction.color;
      text = reaction.text;
    }
    var padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 12);
    double icSize = 24;

    return Row(
      children: [
        GestureDetector(
            onTap: () => setState(() {
                  if (_news[index]["reaction"] != null) {
                    if (widget.data.reactions.isNotEmpty) {
                      widget.data.reactions.removeAt(0);
                    }
                    if (widget.comment != null) {
                      if (widget.comment!.reactions.isNotEmpty) {
                        widget.comment!.reactions.removeAt(0);
                      }
                    }
                  } else {
                    if (widget.data.reactions.isNotEmpty) {
                      if (widget.data.reactions[0].user.name ==
                          currUser!.name) {
                        widget.data.reactions[0].reaction = 0;
                      } else {
                        widget.data.reactions.insert(0, Reaction(currUser!, 0));
                      }
                    } else {
                      widget.data.reactions.insert(0, Reaction(currUser!, 0));
                    }
                    if (widget.comment != null) {
                      if (widget.comment!.reactions.isNotEmpty) {
                        if (widget.comment!.reactions[0].user.name ==
                            currUser!.name) {
                          widget.comment!.reactions[0].reaction = 0;
                        } else {
                          widget.comment!.reactions
                              .insert(0, Reaction(currUser!, 0));
                        }
                      } else {
                        widget.comment!.reactions
                            .insert(0, Reaction(currUser!, 0));
                      }
                    }
                  }
                  // widget.data.reaction = 0;
                  // _news[index]["reaction"] = null;
                  if (widget.reloadState != null) {
                    widget.reloadState!(widget.data);
                  }
                  if (widget.reloadReaction != null) {
                    widget.reloadReaction!(widget.comment!);
                  }
                  if (widget.updateState != null) {
                    widget.updateState!(widget.data);
                  }
                }),
            onLongPressMoveUpdate: _updatePointer,
            onLongPressStart: _savePointer,
            onLongPressEnd: _clearPointer,
            onLongPress: () => {
                  _showReacts(index),
                  createReactArea(context),
                },
            onLongPressUp: _hideReacts,
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Material(
                color: Colors.transparent,
                shape: const StadiumBorder(),
                child: Padding(
                  padding: padding,
                  child: SizedBox(
                    height: icSize,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.reloadState != null) ...[
                          if (reaction != null) ...[
                            if (!isLike) ...[
                              Image.asset(reaction.png,
                                  height: icSize, width: icSize),
                              const SizedBox(width: 8),
                            ]
                          ],
                          if (reaction == null || isLike) ...[
                            Icon(
                              Icons.thumb_up_off_alt,
                              color: isLike ? blue : Colors.grey,
                            )
                          ],
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              text,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.merge(TextStyle(color: textColor)),
                            ),
                          )
                        ] else ...[
                          Text(
                            text,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .merge(TextStyle(color: textColor)),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  void _hideReacts() => _newsCtr.reverse();

  void _showReacts(int index) {
    if (!_newsCtr.isAnimating && !_reactCtr.isAnimating) {
      setState(() => _newsSelected = index);
      _newsCtr.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    //main build function
    _news[0]["reaction"] = null;
    if (widget.data.reactions.isNotEmpty) {
      if (widget.data.reactions[0].user.name == currUser!.name) {
        _setIcon(widget.data.reactions[0].reaction);
      }
    }
    if (widget.comment != null) {
      if (widget.comment!.reactions.isNotEmpty) {
        if (widget.comment!.reactions[0].user.name == currUser!.name) {
          _setIcon(widget.comment!.reactions[0].reaction);
        }
      }
    }
    return Stack(children: [
      _buildItem(context, 0),
      _buildReactAnimation(),
    ]);
  }

  void _savePointer(LongPressStartDetails details) {
    _newsPosition = details;
  }

  void _updatePointer(LongPressMoveUpdateDetails details) {
    var globalOrigin = _newsPosition.globalPosition;
    var newLongPress = globalOrigin + details.offsetFromOrigin;

    List<Rect> rects = _generateRects(details);

    int index = -1;
    for (int i = 0; i < rects.length; i++) {
      if (rects[i].contains(newLongPress)) {
        index = i;
        break;
      }
    }
    if (index == -1) {
      if (_reactSelected != -1) {
        //renew
        _reactions[_reactSelected].reverse();
        _reactSelected = -1;
        _reactRect = Rect.zero;
      }
    } else {
      if (index != _reactSelected) {
        if (_reactSelected != -1) {
          _reactions[_reactSelected].reverse();
        }
        _reactRect = rects[index];
        _reactSelected = index;
        _reactions[_reactSelected].forward();
      }
    }
  }

  List<Rect> _generateRects(LongPressMoveUpdateDetails details) {
    var globalOrigin = _newsPosition.globalPosition;
    var localOrigin = _newsPosition.localPosition;
    // double width = MediaQuery.of(context).size.width;

    var dy = globalOrigin.dy - localOrigin.dy - _reactBarBotMargin;
    dy = dy - _reactBarPadding;
    dy = dy - _reactMargin;

    if (_reactSelected == -1) {
      // var wBar = reactSize * _reactions.length;
      // var x = (width - wBar) / 2.0;
      Offset cursor = Offset(10, dy - 60);
      return List.generate(_reactions.length, (index) {
        double size = reactSize;

        Offset start = cursor;
        Offset end = start + Offset(size, size * 3);
        cursor = cursor + Offset(size, 0);

        return Rect.fromPoints(start, end);
      });
    } else {
      // var wBar = reactSize * _reactions.length + reactScale * reactSize;
      // var x = (width - wBar) / 2.0;
      Offset cursor = Offset(10, dy - 30);
      return List.generate(_reactions.length, (index) {
        double bigSize = (reactScale + 1) * reactSize;
        double size = index == _reactSelected ? bigSize : reactSize;

        Offset start = cursor - Offset(10, (size - reactSize));
        Offset end = start + Offset(size, size * 3);
        cursor = cursor + Offset(size, 0);

        return Rect.fromPoints(start, end);
      });
    }
  }

  void _clearPointer(LongPressEndDetails details) {
    Offset start = _reactRect.center;
    start = start - Offset(0, scaffoldKey.currentState?.appBarMaxHeight ?? 0);

    Offset end = _newsPosition.globalPosition;
    end = Offset(MediaQuery.of(context).size.width / 2.0, end.dy);
    end = end - Offset(0, scaffoldKey.currentState?.appBarMaxHeight ?? 0);

    if (_reactSelected != -1) {
      for (var element in _reactions) {
        element.reverse();
      }
      if (_reactSelected < _reactions.length / 2) {
        _initAnimationPathLeft(start, end);
      } else {
        _initAnimationPathRight(start, end);
      }

      //animate
      var milliseconds = (_reactCtr.duration!.inMilliseconds * 0.7).floor();
      Future.delayed(Duration(milliseconds: milliseconds)).then((_) {
        setState(() {
          _news[_newsSelected]["reaction"] = _reactions[_reactSelected];
          removeOverlay();
        });
      });
      removeOverlay();
      if (widget.data.reactions.isNotEmpty) {
        if (widget.data.reactions[0].user.name == currUser!.name) {
          _changeIcon(widget.data.reactions[0].reaction);
        } else {
          widget.data.reactions.insert(0, Reaction(currUser!, 0));
          _changeIcon(widget.data.reactions[0].reaction);
        }
      } else {
        widget.data.reactions.insert(0, Reaction(currUser!, 0));
        _changeIcon(widget.data.reactions[0].reaction);
      }
      // _changeIcon(widget.data.reaction);
      if (widget.comment != null) {
        if (widget.comment!.reactions.isNotEmpty) {
          if (widget.comment!.reactions[0].user.name == currUser!.name) {
            _changeIcon(widget.comment!.reactions[0].reaction);
          } else {
            widget.comment!.reactions.insert(0, Reaction(currUser!, 0));
            _changeIcon(widget.comment!.reactions[0].reaction);
          }
        } else {
          widget.comment!.reactions.insert(0, Reaction(currUser!, 0));
          _changeIcon(widget.comment!.reactions[0].reaction);
        }
      }
      _reactCtr.forward(from: 0).then((_) {
        //renew
        _newsSelected = -1;
        _reactSelected = -1;
        _reactRect = Rect.zero;
        _newsPosition = const LongPressStartDetails();
      });
    }
    // Future.delayed(Duration:)
    if (widget.reloadState != null) {
      widget.reloadState!(widget.data);
    }
    if (widget.reloadReaction != null) {
      widget.reloadReaction!(widget.comment!);
    }
    if (widget.updateState != null) {
      widget.updateState!(widget.data);
    }
  }

  _initAnimationPathLeft(Offset s, Offset e) {
    setState(() {
      _reactPath = Path();
      _reactPath.moveTo(s.dx, s.dy);
      _reactPath.conicTo(s.dx + 10, s.dy - 30, s.dx + 30, s.dy - 20, 2);
      _reactPath.conicTo(s.dx + 40, s.dy - 15, e.dx, e.dy, 10);
      _reactPath.close();
    });
  }

  _initAnimationPathRight(Offset s, Offset e) {
    setState(() {
      _reactPath = Path();
      _reactPath.moveTo(s.dx, s.dy);
      _reactPath.conicTo(s.dx - 10, s.dy - 30, s.dx - 30, s.dy - 20, 2);
      _reactPath.conicTo(s.dx - 40, s.dy - 15, e.dx, e.dy, 10);
      _reactPath.close();
    });
  }
}
