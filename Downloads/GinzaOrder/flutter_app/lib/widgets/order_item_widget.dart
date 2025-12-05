import 'package:flutter/material.dart';
import '../models/constants.dart';
import '../models/order_model.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderLineItem item;
  final int index;
  final Function(OrderLineItem) onUpdate;
  final Function() onRemove;

  const OrderItemWidget({
    Key? key,
    required this.item,
    required this.index,
    required this.onUpdate,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  late TextEditingController _itemNameController;
  late TextEditingController _quantityController;
  late TextEditingController _rateController;
  late TextEditingController _colorController;
  late TextEditingController _widthController;
  late TextEditingController _remarkController;

  String? _selectedCategory;
  String? _selectedItem;
  String? _selectedUom;
  DateTime? _deliveryDate;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController(text: widget.item.itemName);
    _quantityController = TextEditingController(text: widget.item.quantity);
    _rateController = TextEditingController(text: widget.item.rate.toString());
    _colorController = TextEditingController(text: widget.item.color);
    _widthController = TextEditingController(text: widget.item.width);
    _remarkController = TextEditingController(text: widget.item.remark ?? '');
    _selectedCategory = widget.item.category;
    _selectedUom = widget.item.uom;
    _deliveryDate = widget.item.deliveryDate;
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _rateController.dispose();
    _colorController.dispose();
    _widthController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void _updateItem() {
    final updatedItem = OrderLineItem(
      id: widget.item.id,
      category: _selectedCategory ?? '',
      itemName: _itemNameController.text,
      color: _colorController.text,
      width: _widthController.text,
      uom: _selectedUom ?? 'Meter',
      quantity: _quantityController.text,
      rate: double.tryParse(_rateController.text) ?? 0,
      discount: 0,
      deliveryDate: _deliveryDate ?? DateTime.now(),
      remark: _remarkController.text,
    );
    widget.onUpdate(updatedItem);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item ${widget.index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Category Selection
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: ItemCategory.getAllCategories()
                  .map(
                    (cat) =>
                        DropdownMenuItem(value: cat.id, child: Text(cat.name)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  _selectedItem = null;
                });
                _updateItem();
              },
            ),
            const SizedBox(height: 12),

            // Item Name / Selection
            if (_selectedCategory != null)
              DropdownButtonFormField<String>(
                value: _selectedItem,
                decoration: InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ItemCategory.getAllCategories()
                    .firstWhere((cat) => cat.id == _selectedCategory)
                    .items
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                    _itemNameController.text = value ?? '';
                  });
                  _updateItem();
                },
              )
            else
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (_) => _updateItem(),
              ),
            const SizedBox(height: 12),

            // Color & Width
            if (isMobile)
              Column(
                children: [
                  TextField(
                    controller: _colorController,
                    decoration: InputDecoration(
                      labelText: 'Color',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (_) => _updateItem(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _widthController,
                    decoration: InputDecoration(
                      labelText: 'Width',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (_) => _updateItem(),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _colorController,
                      decoration: InputDecoration(
                        labelText: 'Color',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (_) => _updateItem(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _widthController,
                      decoration: InputDecoration(
                        labelText: 'Width',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (_) => _updateItem(),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),

            // Quantity, Rate, UOM
            if (isMobile)
              Column(
                children: [
                  TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _updateItem(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _rateController,
                    decoration: InputDecoration(
                      labelText: 'Rate',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _updateItem(),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedUom,
                    decoration: InputDecoration(
                      labelText: 'UOM',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: MEASUREMENT_UNITS
                        .map(
                          (uom) =>
                              DropdownMenuItem(value: uom, child: Text(uom)),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedUom = value);
                      _updateItem();
                    },
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _quantityController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _updateItem(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _rateController,
                      decoration: InputDecoration(
                        labelText: 'Rate',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _updateItem(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedUom,
                      decoration: InputDecoration(
                        labelText: 'UOM',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: MEASUREMENT_UNITS
                          .map(
                            (uom) =>
                                DropdownMenuItem(value: uom, child: Text(uom)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => _selectedUom = value);
                        _updateItem();
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),

            // Delivery Date
            ListTile(
              title: const Text('Delivery Date'),
              subtitle: Text(
                _deliveryDate != null
                    ? '${_deliveryDate!.day}/${_deliveryDate!.month}/${_deliveryDate!.year}'
                    : 'Not selected',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _deliveryDate ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _deliveryDate = date);
                  _updateItem();
                }
              },
            ),
            const SizedBox(height: 12),

            // Remark
            TextField(
              controller: _remarkController,
              decoration: InputDecoration(
                labelText: 'Remark',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 2,
              onChanged: (_) => _updateItem(),
            ),
            const SizedBox(height: 12),

            // Total
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Item Total:'),
                  Text(
                    '₹${((double.tryParse(_quantityController.text) ?? 0) * (double.tryParse(_rateController.text) ?? 0)).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
