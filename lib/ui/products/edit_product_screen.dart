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
        id: null,
        name: '', 
        images: [], 
        information: '', 
        type: '',
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> _imageControllers = [];
  // final _imageUrlController = TextEditingController();
  List<FocusNode> _imageFocusNodes = [];
  // final _imageUrlFocusNode = FocusNode(); //điều khiển tập trung
  final _editForm = GlobalKey<FormState>(); //  truy cập đến một widget từ bất kỳ đâu
  late Product _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return ((value.startsWith('http') || value.startsWith('https')) &&
      (value.endsWith('.png') || value.endsWith('.jpg') || value.endsWith('.jpeg'))
    );
  }

  @override
  void initState() {
    _imageControllers = List.generate(widget.product.images.length, (index) => TextEditingController());
    _imageFocusNodes = List.generate(widget.product.images.length, (index) => FocusNode());
    super.initState();
    for (int i = 0; i < widget.product.images.length; i++) {
      _imageFocusNodes[i].addListener(() {
        if (!_imageFocusNodes[i].hasFocus) {
          if (!_isValidImageUrl(_imageControllers[i].text)) {
            return;
          }
          setState(() {
            
          });
        }
      });
    }
    
    _editedProduct = widget.product;
    for (int i = 0; i < _editedProduct.images.length; i++) {
      _imageControllers[i].text = _editedProduct.images[i];
    }

    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < _editedProduct.images.length; i++) {
      _imageControllers[i].dispose();
      _imageFocusNodes[i].dispose();
    }
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
      _editedProduct = _editedProduct.copyWith(
        images: _imageControllers.map((controller) => controller.text).toList(),
      );

      final productsManager = context.read<ProductsManager>();
      if (_editedProduct.id != null) {
        await productsManager.updateProduct(_editedProduct);
      } else {
        await productsManager.addProduct(_editedProduct);
      }
    } catch (e) {
      if (mounted) {
        await showErrorDialog(context, 'Đã xảy ra sự cố.');
      }
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
        title: Text(
          _editedProduct.id != null ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm',
          style: const TextStyle(color: Color.fromARGB(255, 245, 245, 245))
        ),
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
                const SizedBox(height: 10,),
                _buildNameField(),
                const SizedBox(height: 10,),
                _buildPriceField(),
                const SizedBox(height: 10,),
                _buildInformationField(),
                const SizedBox(height: 10,),
                _buildTypeField(),
                const SizedBox(height: 10,),
                _buildProductPreview(),
              ],
            ),
          ),
        ),
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      initialValue: _editedProduct.name,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Tên sản phẩm'
      ),
      textInputAction: TextInputAction.next,
      // autofocus: true,
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Giá'
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Không được trống.';
        }
        if (int.tryParse(value) == null) {
          return 'Vui lòng nhập giá trị số.';
        }
        if (int.parse(value) <= 0) {
          return 'Vui lòng nhập số tiền lớn hơn 0,';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: int.parse(value!));
      },
    );
  }

  TextFormField _buildInformationField() {
    return TextFormField(
      initialValue: _editedProduct.information,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Thông tin chi tiết'
      ),
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

  String? _selectedItem;

  Widget _buildTypeField() {
    final List<String> items = ['Moraine', 'Melissani', 'Sicily', 'Kashmir', 'Weimar'];
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _selectedItem,
            hint: const Text('Chọn phân loại'),
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
                _editedProduct = _editedProduct.copyWith(type: value);
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item)
              );
            }).toList(),
            // onSaved: (value) {
            //   if (value != null) {
            //     _editedProduct = _editedProduct.copyWith(type: value);
            //   }
            // },
          ),
        ],
      ),
    );
  }

  Widget _buildProductPreview() {
    return Column(
      children: [
        Container(
          height: 100,
          margin: const EdgeInsets.only(top: 8, right: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _imageControllers.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: _imageControllers[index].text.isEmpty
                    ? Text('Hình ảnh ${index + 1}')
                    : FittedBox(
                        child: Image.network(
                          _imageControllers[index].text,
                          fit: BoxFit.cover,
                        ),
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: 10,),
        // _buildImageField(),
        Column(
          children: [
            for (int i = 0; i < _editedProduct.images.length; i++) (
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 310,
                      child: _buildImageField(i),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _editedProduct.images.removeAt(i);
                          _imageControllers.removeAt(i);
                          _imageFocusNodes.removeAt(i);

                        });
                      }, 
                      icon: const Icon(Icons.close)
                    )
                  ],
                ),
              )
            ),
            
            Row(
              children: [
                const Text('Thêm link hình ảnh'),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _editedProduct.images.add('');
                      _imageControllers.add(TextEditingController());
                      _imageFocusNodes.add(FocusNode());
                    });
                  }, 
                  icon: const Icon(Icons.add),
                )
              ],
            )
          ],
        )
        
      ],
    );
  }

  TextFormField _buildImageField(int index) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Link hình ảnh ${index + 1}',
      ),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageControllers[index],
      focusNode: _imageFocusNodes[index],
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Vui lòng nhập vào link hình ảnh.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Vui lòng nhập đúng link hình ảnh.';
        }
        return null;
      },
      onSaved: (_) {
        setState(() {
          _editedProduct = _editedProduct.copyWith(images: [..._editedProduct.images, _imageControllers[index].text]);
        });
      },

    );
  }
}