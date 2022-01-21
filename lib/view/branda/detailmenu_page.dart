import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:java_code_app/helps/image.dart';
import 'package:java_code_app/models/menudetail.dart';
import 'package:java_code_app/providers/order_providers.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/theme/colors.dart';
import 'package:java_code_app/theme/icons_cs_icons.dart';
import 'package:java_code_app/theme/spacing.dart';
import 'package:java_code_app/theme/text_style.dart';
import 'package:java_code_app/widget/addorder_button.dart';
import 'package:java_code_app/widget/appbar.dart';
import 'package:java_code_app/widget/detailmenu_sheet.dart';
import 'package:java_code_app/widget/label_toppingselection.dart';
import 'package:java_code_app/widget/labellevel_selection.dart';
import 'package:java_code_app/widget/listmenu_tile.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class DetailMenu extends StatefulWidget {
  final int countOrder, id;

  const DetailMenu({
    Key? key,
    required this.countOrder,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  int _jumlahOrder = 0;
  Level? _selectedLevel;
  List<Level> _selectedTopping = [];
  List<Level> _listLevel = [];
  List<Level> _listTopping = [];
  String _catatan = "";
  final TextEditingController _editingController = TextEditingController();
  static bool _isLoading = true;

  Menu? _data;

  getMenu() async {
    if (mounted) setState(() => _isLoading = true);
    final data = await Provider.of<OrderProviders>(context, listen: false).getDetailMenu(id: widget.id);

    if (data != null) {
      _data = data.data.menu;

      if (data.data.topping?.isNotEmpty ?? false) {
        _selectedTopping = [data.data.topping!.first];
      }
      if (data.data.level?.isNotEmpty ?? false) {
        _selectedLevel = data.data.level!.first;
      }

      _listLevel = data.data.level ?? [];
      _listTopping = data.data.topping ?? [];

      final orders =
          Provider.of<OrderProviders>(context, listen: false).checkOrder;

      if (orders.containsKey("${_data?.idMenu}")) {
        final dat = orders["${_data?.idMenu}"];

        // _jumlahOrder = dat["countOrder"];

        if(dat["level"] != null) {
          final _level = data.data.level
              ?.where((element) => "${element.idDetail}" == dat["level"]);
          if (_level?.isNotEmpty ?? false) _selectedLevel = _level!.first;
        }

        if(dat["topping"] != null) {
          _selectedTopping = data.data.topping?.where((element) {
            return dat["topping"].where((e) => e == "${element.idDetail}") !=
                null;
          }).toList() ?? _selectedTopping;
        }

        if (dat["catatan"] != null) _catatan = dat["catatan"];
      }

      _isLoading = false;
    }

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _jumlahOrder = widget.countOrder;

    getMenu();
    super.initState();
  }

  _showDialogLevel(List<Level>? _listLevel) async {
    if (_listLevel?.isEmpty ?? false) return;
    Level _value = _listLevel!.first;
    _value = await showModalBottomSheet(
      barrierColor: ColorSty.grey.withOpacity(0.2),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (_, setState) {
            return BottomSheetDetailMenu(
              title: "Pilih Level",
              content: Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (Level item in _listLevel)
                      LabelLevelSelection(
                        data: item,
                        isSelected: item == _selectedLevel,
                        onSelection: (Level value) {
                          setState(() => _selectedLevel = value);
                          Navigator.of(context).pop(value);
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    setState(() => _selectedLevel = _value);
  }

  _showDialogTopping(List<Level>? _listTopping) async {
    if (_listTopping?.isEmpty ?? false) return;
    showModalBottomSheet(
      barrierColor: ColorSty.grey.withOpacity(0.2),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (_) => BottomSheetDetailMenu(
        title: "Pilih Toping",
        content: Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final item in _listTopping!)
                LabelToppingSelection(
                  data: item,
                  initial: _selectedTopping.where((e) => e == item).isNotEmpty,
                  onSelection: (value) {
                    if (_selectedTopping.where((e) => e == value).isNotEmpty) {
                      setState(() => _selectedTopping.remove(value));
                    } else {
                      setState(() => _selectedTopping.add(value));
                    }
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  void _viewImage() => Navigate.toViewImage(context, urlImage: "urlImage");

  void _addCatatan() {
    setState(() => _catatan = _editingController.text);
    Navigator.pop(context);
  }

  void _tambahkanPesanan() {
    if (_data == null) return;

    final orders =
        Provider.of<OrderProviders>(context, listen: false).checkOrder;

    final data = {
      "id": "${widget.id}",
      "jenis": _data!.kategori,
      "image": _data!.foto,
      "harga": _data!.harga,
      "amount": _data!.status,
      "name": _data!.nama,
    };

    if (_jumlahOrder > 0) {
      if (orders.keys.contains("${widget.id}")) {
        Provider.of<OrderProviders>(context, listen: false).editOrder(
          id: "${widget.id}",
          jumlahOrder: _jumlahOrder,
          topping: _selectedTopping,
          level: _selectedLevel,
          catatan: _catatan,
        );
      } else {
        Provider.of<OrderProviders>(context, listen: false).addOrder(
          data: data,
          jumlahOrder: _jumlahOrder,
          topping: _selectedTopping,
          level: _selectedLevel,
          catatan: _catatan,
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_jumlahOrder);
    return Scaffold(
      backgroundColor: ColorSty.bg2,
      appBar: const CostumeAppBar(
        title: 'Detail Menu',
        back: true,
      ),
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            const SizedBox(height: SpaceDims.sp24),
            GestureDetector(
              onTap: _viewImage,
              child: SizedBox(
                width: 234.0,
                height: 182.4,
                child: Hero(
                  tag: "image",
                  child: Image.network(
                    _data != null ? _data!.foto ?? "" : "",
                    loadingBuilder: imageOnLoad,
                    errorBuilder: imageError,
                  ),
                ),
              ),
            ),
            const SizedBox(height: SpaceDims.sp24),
            Container(
              decoration: BoxDecoration(
                color: ColorSty.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -1),
                    color: ColorSty.grey.withOpacity(0.02),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SpaceDims.sp24,
                      left: SpaceDims.sp24,
                      right: SpaceDims.sp24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_isLoading)
                          const SkeletonText(height: 16.0)
                        else
                          Text(
                            "${_data?.nama}",
                            style: TypoSty.title.copyWith(
                              color: ColorSty.primary,
                            ),
                          ),
                        AddOrderButton(
                          initCount: _jumlahOrder,
                          onChange: (int value) {
                            setState(() => _jumlahOrder = value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: SpaceDims.sp12,
                      left: SpaceDims.sp24,
                      right: 108.0,
                    ),
                    child: _isLoading
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SkeletonText(height: 12.0),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                child: SkeletonText(height: 12.0),
                              ),
                              SizedBox(
                                width: 120,
                                child: SkeletonText(height: 12.0),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 100.0,
                            child: Text(
                              _data?.deskripsi ?? "",
                              overflow: TextOverflow.fade,
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: SpaceDims.sp24,
                      right: SpaceDims.sp24,
                    ),
                    child: Column(
                      children: [
                        TileListDMenu(
                          icon: IconsCs.cash,
                          isLoading: _isLoading,
                          title: "Harga",
                          prefix: !_isLoading ? "Rp ${_data?.harga}" : "Rp 0",
                          onPressed: () {},
                        ),
                        TileListDMenu(
                          prefixIcon: true,
                          isLoading: _isLoading,
                          icon: IconsCs.fire,
                          title: "Level",
                          prefix: _selectedLevel?.keterangan,
                          onPressed: () => _showDialogLevel(_listLevel),
                        ),
                        TileListDMenu(
                          prefixIcon: true,
                          isLoading: _isLoading,
                          iconSvg: SvgPicture.asset(
                            "assert/image/icons/topping-icon.svg",
                            height: 22.0,
                          ),
                          prefixCostume: RichText(
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                style: TypoSty.captionSemiBold
                                    .copyWith(color: ColorSty.black),
                                text: _selectedTopping.isEmpty
                                    ? ""
                                    : _selectedTopping.first.keterangan,
                                children: [
                                  for (var i = 0;
                                      i < _selectedTopping.length;
                                      i++)
                                    if (i > 0)
                                      TextSpan(
                                        text:
                                            ", ${_selectedTopping[i].keterangan}",
                                        style: TypoSty.captionSemiBold.copyWith(
                                          color: ColorSty.black,
                                        ),
                                      )
                                ]),
                          ),
                          title: "Topping",
                          onPressed: () => _showDialogTopping(_listTopping),
                        ),
                        TileListDMenu(
                          prefixIcon: true,
                          icon: IconsCs.note,
                          isLoading: _isLoading,
                          title: "Catatan",
                          prefix: _catatan.isEmpty
                              ? "Lorem Ipsum sit aaasss"
                              : _catatan,
                          onPressed: () => showModalBottomSheet(
                            barrierColor: ColorSty.grey.withOpacity(0.2),
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) =>
                                BottomSheetDetailMenu(
                              title: "Buat Catatan",
                              content: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      maxLength: 100,
                                      controller: _editingController,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: _addCatatan,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      minimumSize: const Size(25.0, 25.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                    ),
                                    child: const Icon(Icons.check, size: 26.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: SpaceDims.sp12),
                        ElevatedButton(
                          onPressed: _tambahkanPesanan,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: SpaceDims.sp2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Tambahkan Ke Pesanan",
                                style: TypoSty.button,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
