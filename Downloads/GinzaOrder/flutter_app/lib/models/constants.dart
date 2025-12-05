class Branch {
  final String id;
  final String name;
  final String location;

  const Branch({required this.id, required this.name, required this.location});

  static List<Branch> getAllBranches() => [
    Branch(id: 'ahmedabad', name: 'Ahmedabad', location: 'Gujarat'),
    Branch(id: 'bengaluru', name: 'Bengaluru', location: 'Karnataka'),
    Branch(id: 'chandigarh', name: 'Chandigarh', location: 'Punjab'),
    Branch(id: 'mumbai', name: 'Mumbai', location: 'Maharashtra'),
  ];
}

class SalesPerson {
  final String id;
  final String name;
  final String branch;
  final String contactNo;

  const SalesPerson({
    required this.id,
    required this.name,
    required this.branch,
    required this.contactNo,
  });

  static List<SalesPerson> getSalesPersonsByBranch(String branchId) {
    const Map<String, List<SalesPerson>> salesPersonMap = {
      'ahmedabad': [
        SalesPerson(
          id: 'sp_ahm_1',
          name: 'Rajesh Kumar',
          branch: 'ahmedabad',
          contactNo: '9876543210',
        ),
        SalesPerson(
          id: 'sp_ahm_2',
          name: 'Priya Sharma',
          branch: 'ahmedabad',
          contactNo: '9876543211',
        ),
      ],
      'bengaluru': [
        SalesPerson(
          id: 'sp_blr_1',
          name: 'Amit Patel',
          branch: 'bengaluru',
          contactNo: '9876543212',
        ),
        SalesPerson(
          id: 'sp_blr_2',
          name: 'Deepak Singh',
          branch: 'bengaluru',
          contactNo: '9876543213',
        ),
      ],
      'chandigarh': [
        SalesPerson(
          id: 'sp_cgh_1',
          name: 'Harpreet Kaur',
          branch: 'chandigarh',
          contactNo: '9876543214',
        ),
        SalesPerson(
          id: 'sp_cgh_2',
          name: 'Naveen Kumar',
          branch: 'chandigarh',
          contactNo: '9876543215',
        ),
      ],
      'mumbai': [
        SalesPerson(
          id: 'sp_mum_1',
          name: 'Vikram Desai',
          branch: 'mumbai',
          contactNo: '9876543216',
        ),
        SalesPerson(
          id: 'sp_mum_2',
          name: 'Neha Kapoor',
          branch: 'mumbai',
          contactNo: '9876543217',
        ),
      ],
    };

    return salesPersonMap[branchId] ?? [];
  }
}

class ItemCategory {
  final String id;
  final String name;
  final List<String> items;

  const ItemCategory({
    required this.id,
    required this.name,
    required this.items,
  });

  static List<ItemCategory> getAllCategories() => [
    ItemCategory(
      id: 'fabrics',
      name: 'Fabrics',
      items: ['Cotton', 'Silk', 'Linen', 'Wool', 'Polyester'],
    ),
    ItemCategory(
      id: 'garments',
      name: 'Garments',
      items: ['Shirt', 'Trousers', 'Saree', 'Dress', 'Jacket'],
    ),
    ItemCategory(
      id: 'accessories',
      name: 'Accessories',
      items: ['Buttons', 'Thread', 'Zip', 'Label', 'Tag'],
    ),
  ];
}

const List<String> MEASUREMENT_UNITS = ['Meter', 'Piece', 'Dozen', 'Box', 'Kg'];
