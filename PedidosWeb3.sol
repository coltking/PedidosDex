pragma solidity ^0.8.0;

contract PedidosWeb3 {

  // Variables globales

  address payable owner;
  address payable restaurant;
  address payable customer;
  uint256 amount;
  string[] items;

  // Constructor

  constructor() {
    owner = msg.sender;
  }

  // Función para crear un pedido

  function createOrder(address payable restaurant, address payable customer, uint256 amount, string[] items) public {
    require(restaurant != address(0), "El restaurante no puede ser nulo");
    require(customer != address(0), "El cliente no puede ser nulo");
    require(amount > 0, "El monto debe ser mayor que 0");
    require(items.length > 0, "Los artículos deben tener una longitud mayor que 0");

    this.restaurant = restaurant;
    this.customer = customer;
    this.amount = amount;
    this.items = items;

    emit OrderCreated(restaurant, customer, amount, items);
  }

  // Función para pagar el pedido

  function payOrder() public payable {
    require(msg.sender == this.customer, "Solo el cliente puede pagar el pedido");
    require(msg.value >= this.amount, "El monto pagado debe ser igual o mayor que el monto del pedido");

    this.restaurant.transfer(this.amount);

    emit OrderPaid(restaurant, customer, amount);
  }

  // Función para confirmar la entrega del pedido

  function confirmDelivery() public {
    require(msg.sender == this.restaurant, "Solo el restaurante puede confirmar la entrega del pedido");

    this.emit OrderDelivered(restaurant, customer, amount, items);
  }

  // EventEmitters

  event OrderCreated(address restaurant, address customer, uint256 amount, string[] items);
  event OrderPaid(address restaurant, address customer, uint256 amount);
  event OrderDelivered(address restaurant, address customer, uint256 amount, string[] items);
}