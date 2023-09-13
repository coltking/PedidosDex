contract PedidosWeb3 {

// Variables globales

address payable owner;
address payable restaurant;
address payable customer;
address payable cadette;
uint256 amount;
string[] items;
uint256 cadetteFee; // La tarifa del cadete

// Constructor

constructor() {
owner = msg.sender;
}

// Función para crear un pedido

function createOrder(address payable restaurant, address payable customer, address payable cadette, uint256 amount, string[] items) public {
require(restaurant != address(0), "El restaurante no puede ser nulo");
require(customer != address(0), "El cliente no puede ser nulo");
require(cadette != address(0), "El cadete no puede ser nulo");
require(amount > 0, "El monto debe ser mayor que 0");
require(items.length > 0, "Los articulos deben tener una longitud mayor que 0");

this.restaurant = restaurant;
this.customer = customer;
this.amount = amount;
this.items = items;
this.cadetteFee = 100; // Se establece el valor predeterminado de la tarifa del cadete

cadette.transfer(amount); // El cadete bloquea el monto del pedido en el contrato

emit OrderCreated(restaurant, customer, cadette, amount, items);
}

// Función para pagar el pedido

function payOrder() public payable {
require(msg.sender == this.customer, "Solo el cliente puede pagar el pedido");
require(msg.value == this.amount + this.cadetteFee, "El monto pagado debe ser igual al monto del pedido y la tarifa del cadete");

this.amount = this.amount - this.cadetteFee;

emit OrderPaid(restaurant, customer, this.amount);
}

// Función para liberar los fondos del pedido al restaurante

function releaseFunds() public {
require(msg.sender == this.cadette, "Solo el cadete puede liberar los fondos");
require(this.amount > 0, "No hay fondos para liberar");

if (this.customer.receivedDeliveryConfirmation()) { // Si el cliente ha confirmado la recepción del pedido
cadette.transfer(this.cadetteFee); // El cadete recibe el pago de la tarifa del cadete
this.restaurant.transfer(this.amount);
emit FundsReleased(restaurant, this.amount);
} else {
// Si el cliente no ha confirmado la recepción del pedido, se da por entregado después de un tiempo
uint24 hours = 60 * 60 * 15; // 15 minutos
setTimeout(function() {
destroyFunds();
}, hours);
}
}

// Función para destruir los fondos

function destroyFunds() public {
require(now >= this.expiryDate, "El período de espera ha expirado");

selfdestruct(msg.sender);
}

// EventEmitters

event OrderCreated(address restaurant, address customer, address cadette, uint256 amount, string[] items);
event OrderPaid(address restaurant, address customer, uint256 amount);
event FundsReleased(address restaurant, uint256 amount);
}
