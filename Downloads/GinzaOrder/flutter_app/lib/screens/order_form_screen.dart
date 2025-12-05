import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/constants.dart';
import '../models/order_model.dart';
import '../services/supabase_service.dart';
import '../services/google_sheets_service.dart';
import '../widgets/order_item_widget.dart';

class OrderFormScreen extends StatefulWidget {
  const OrderFormScreen({Key? key}) : super(key: key);

  @override
  State<OrderFormScreen> createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Form controllers
  late final TextEditingController _customerNameController = TextEditingController();
  late final TextEditingController _customerPhoneController = TextEditingController();
  late final TextEditingController _customerEmailController = TextEditingController();
  late final TextEditingController _billingAddressController = TextEditingController();
  late final TextEditingController _deliveryAddressController = TextEditingController();
  late final TextEditingController _discountController = TextEditingController(text: '0');

  String? _selectedBranch;
  String? _selectedSalesPerson;
  List<SalesPerson> _salesPersonList = [];
  List<OrderLineItem> _items = [];
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _items.add(OrderLineItem(
      id: '1',
      category: '',
      itemName: '',
      color: '',
      width: '',
      uom: 'Meter',
      quantity: '',
      rate: 0,
      discount: 0,
      deliveryDate: DateTime.now(),
    ));
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _customerEmailController.dispose();
    _billingAddressController.dispose();
    _deliveryAddressController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void _addItemRow() {
    setState(() {
      _items.add(OrderLineItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        category: '',
        itemName: '',
        color: '',
        width: '',
        uom: 'Meter',
        quantity: '',
        rate: 0,
        discount: 0,
        deliveryDate: DateTime.now(),
      ));
    });
  }

  void _removeItemRow(int index) {
    setState(() => _items.removeAt(index));
  }

  void _updateItem(int index, OrderLineItem item) {
    setState(() => _items[index] = item);
  }

  double _calculateSubtotal() {
    return _items.fold(0, (sum, item) => sum + item.total);
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBranch == null || _selectedSalesPerson == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select branch and sales person')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final orderData = {
        'branch': _selectedBranch,
        'sales_person': _selectedSalesPerson,
        'customer_name': _customerNameController.text,
        'customer_phone': _customerPhoneController.text,
        'customer_email': _customerEmailController.text,
        'billing_address': _billingAddressController.text,
        'delivery_address': _deliveryAddressController.text,
        'items': _items.map((item) => item.toJson()).toList(),
        'subtotal': _calculateSubtotal(),
        'discount': double.tryParse(_discountController.text) ?? 0,
        'total': _calculateSubtotal() - (double.tryParse(_discountController.text) ?? 0),
        'order_date': DateTime.now().toIso8601String(),
      };

      // Submit to Google Sheets
      final sheetSuccess = await GoogleSheetsService.submitOrderToSheet(orderData);

      // Also save to Supabase
      await SupabaseService.saveOrder(orderData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              sheetSuccess
                  ? 'Order submitted successfully!'
                  : 'Order saved (Sheet sync failed)',
            ),
            backgroundColor: Colors.green,
          ),
        );

        // Reset form
        _formKey.currentState!.reset();
        _customerNameController.clear();
        _customerPhoneController.clear();
        _customerEmailController.clear();
        _billingAddressController.clear();
        _deliveryAddressController.clear();
        _discountController.text = '0';
        setState(() => _items = [
          OrderLineItem(
            id: '1',
            category: '',
            itemName: '',
            color: '',
            width: '',
            uom: 'Meter',
            quantity: '',
            rate: 0,
            discount: 0,
            deliveryDate: DateTime.now(),
          )
        ]);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SupabaseService.logout();
              if (mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Branch Selection
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DropdownButtonFormField<String>(
                  value: _selectedBranch,
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: Branch.getAllBranches()
                      .map((b) => DropdownMenuItem(
                            value: b.id,
                            child: Text(b.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBranch = value;
                      _selectedSalesPerson = null;
                      _salesPersonList = SalesPerson.getSalesPersonsByBranch(value ?? '');
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a branch' : null,
                ),
              ),

              // Sales Person Selection
              if (_salesPersonList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DropdownButtonFormField<String>(
                    value: _selectedSalesPerson,
                    decoration: InputDecoration(
                      labelText: 'Sales Person',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: _salesPersonList
                        .map((sp) => DropdownMenuItem(
                              value: sp.id,
                              child: Text(sp.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedSalesPerson = value);
                    },
                    validator: (value) => value == null
                        ? 'Please select a sales person'
                        : null,
                  ),
                ),

              // Customer Details Section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Customer Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _customerPhoneController,
                decoration: InputDecoration(
                  labelText: 'Contact No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _customerEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _billingAddressController,
                decoration: InputDecoration(
                  labelText: 'Billing Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _deliveryAddressController,
                decoration: InputDecoration(
                  labelText: 'Delivery Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 2,
              ),

              // Items Section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Order Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Items List
              ..._items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrderItemWidget(
                    item: item,
                    index: index,
                    onUpdate: (updatedItem) => _updateItem(index, updatedItem),
                    onRemove: () => _removeItemRow(index),
                  ),
                );
              }),

              // Add Item Button
              ElevatedButton.icon(
                onPressed: _addItemRow,
                icon: const Icon(Icons.add),
                label: const Text('Add Item'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),

              // Summary Section
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:'),
                        Text(
                          '₹${_calculateSubtotal().toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Discount:'),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _discountController,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '₹${(_calculateSubtotal() - (double.tryParse(_discountController.text) ?? 0)).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF1e3a8a),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Submit Button
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1e3a8a),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Text(
                          'Submit Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
