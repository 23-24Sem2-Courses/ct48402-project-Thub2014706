import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:ct484_project/ui/shared/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routerName = '/edit-product';

  late final Product product;

  EditProductScreen(
    Product? product, {
      super.key,
    }
  ) {
    if (product == null) {
      this.product = Product(
        name: '', 
        images: [], 
        information: '', 
        price: 0
      );
    } else {
      this.product = product;
    }
  }

  @override
  State<EditProductScreen> createState() => _EditProductScreen();
}

class _EditProductScreen extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode(); //điều khiển tập trung
  final _editForm = GlobalKey<FormState>(); //  truy cập đến một widget từ bất kỳ đâu
  late Product _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https') &&
      value.endsWith('.png') || value.endsWith('.jpg') || value.endsWith('.jpeg')
    );
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {
          
        });
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.images[0];
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        productsManager.updateProduct(_editedProduct);
      } else {
        productsManager.addProduct(_editedProduct);
      }
    } catch (e) {
      await showErrorDialog(context, 'Đã xảy ra sự cố.');
    }
    
    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật sản phẩm'),
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm, 
            icon: const Icon(Icons.save)
          )
        ],
      ),
      body: _isLoading ?
        const Center(
          child: CircularProgressIndicator(),
        ) : Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _editForm,
            child: ListView(
              children: <Widget>[
                _buildNameField(),

              ],
            ),
          ),
        ),
    );
  }

  TextFormField _buildNameField() {
  return TextFormField(
    initialValue: _editedProduct.name,
    decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
    textInputAction: TextInputAction.next,
    autofocus: true,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Không được trống.';
      }
      return null;
    },
    onSaved: (value) {
      _editedProduct = _editedProduct.copyWith(name: value);
    },
  );
}

TextFormField _buildPriceField() {
  return TextFormField(
    initialValue: _editedProduct.price.toString(),
    decoration: const InputDecoration(labelText: 'Giá'),
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.number,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Không được trống.';
      }
      if (double.tryParse(value) == null) {
        return 'Vui lòng nhập giá trị số.';
      }
      if (double.parse(value) <= 0) {
        return 'Vui lòng nhập số tiền lớn hơn 0,';
      }
      return null;
    },
    onSaved: (value) {
      _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
    },
  );
}

TextFormField _buildInformationField() {
  return TextFormField(
    initialValue: _editedProduct.information,
    decoration: const InputDecoration(labelText: 'Thông tin chi tiết'),
    maxLines: 3,
    keyboardType: TextInputType.multiline,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Vui lòng nhập thông tin chi tiết.';
      }
      if (value.length < 10) {
        return 'Nhập ít nhất 10 ký tự';
      }
      return null;
    },
    onSaved: (value) {
      _editedProduct = _editedProduct.copyWith(information: value);
    },
  );
}

}

