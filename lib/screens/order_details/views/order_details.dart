import 'package:flutter/material.dart';
import 'package:shop/models/order_item.dart';
import 'package:shop/services/api_service.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String status;

  const OrderDetailsScreen({Key? key, required this.status}) : super(key: key);
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  List<OrderDetailsItem> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrder();
  }

  void loadOrder() async {
    final result = await ApiService.getOrdersByStatus(widget.status);
    setState(() {
      orders = result;
    });
  }

  final steps = const [
    "Đang chờ xử lý",
    "Đã xác nhận",
    "Đang vận chuyển",
    "Đã vận chuyển",
    "Đã hủy"
  ];
  int getStepFromStatus(String status) {
    switch (status) {
      case 'PENDING':
        return 1;
      case 'CONFIRMED':
        return 2;
      case 'SHIPPED':
        return 3;
      case 'DELIVERED':
        return 4;
      case 'CANCELLED':
        return 5;
      default:
        return 0; // Unknown status
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Delivered"),
          leading: const BackButton(),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final orderItem = orders[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(orderItem.product.productName,
                            style:
                                const TextStyle(fontFamily: 'Times New Roman')),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                    // const SizedBox(height: 4),
                    // Text(orderItem.order.address),
                    const SizedBox(height: 16),
                    // Timeline (you can update based on your needs)
                    StepStatusTimeline(
                      steps: steps,
                      currentStep:
                          getStepFromStatus(orderItem.order.status!) - 1,
                    ),
                    const SizedBox(height: 16),
                    // child: _buildProductItem(
                    //   productName: product.productName,
                    //   price: product.price,
                    //   imageUrl: product.pictures,
                    //   orderStatus: orderItem.order.status!,
                    //   quantity: orderItem.quantity,
                    // ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildProductItem({
    required String productName,
    required int price,
    required String imageUrl,
    required String orderStatus,
    required int quantity,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
          ),
        ),
        title: Text(productName, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$price đ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Trạng thái: $orderStatus',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Text('x$quantity'),
      ),
    );
  }
}

class StepStatusTimeline extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const StepStatusTimeline({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (index != 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isActive ? Colors.green : Colors.grey.shade300,
                      ),
                    ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor:
                        isActive ? Colors.green : Colors.grey.shade300,
                    child: Icon(Icons.check,
                        size: 14, color: isActive ? Colors.white : Colors.grey),
                  ),
                  if (index != steps.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: (index + 1 <= currentStep)
                            ? Colors.green
                            : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                steps[index],
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
