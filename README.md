# PedidosDex!
### Un delivery descentralizado impulsado por los contratos inteligentes.
###### este proyecto es solo un concepto, el smart contract fue generado con chatGPT 3.5 con el unico fin de que se comprenda el concepto inicial. 
###### quien desee que me dedique al desarrollo completo de este concepto puede buscar la direccion de lightning network en el pie de pagina.


Este código es un contrato inteligente escrito en Solidity, un lenguaje de programación utilizado para crear aplicaciones descentralizadas en la plataforma Ethereum. El contrato se llama "PedidosWeb3" y parece estar diseñado para gestionar pedidos de entrega de comida a través de una cadena de suministro en Ethereum. A continuación, te explicaré las principales funciones y su propósito:

Variables globales: El contrato tiene varias variables globales, incluyendo direcciones de diferentes partes involucradas en el pedido (propietario, restaurante, cliente, cadete), el monto del pedido, una lista de artículos y la tarifa del cadete.

Constructor: El constructor se ejecuta una sola vez al desplegar el contrato y establece al propietario del contrato como la dirección que lo desplegó.

Función createOrder: Esta función se utiliza para crear un nuevo pedido. Toma como argumentos las direcciones del restaurante, cliente y cadete, el monto del pedido y una lista de artículos. Antes de crear el pedido, se realizan varias comprobaciones para asegurarse de que los valores sean válidos. Luego, se establecen las variables del contrato con estos valores, incluyendo una tarifa predeterminada para el cadete. Además, se realiza una transferencia al cadete para bloquear el monto del pedido en el contrato, y se emite un evento OrderCreated para registrar la creación del pedido.

Función payOrder: Esta función se utiliza para que el cliente pague el pedido. Solo el cliente puede invocar esta función, y debe enviar una cantidad igual al monto del pedido más la tarifa del cadete. Si la cantidad es correcta, se descuenta la tarifa del cadete del monto total del pedido, y se emite un evento OrderPaid para registrar el pago.

Función releaseFunds: Esta función permite al cadete liberar los fondos del pedido una vez que se ha entregado. El cadete es la única parte que puede invocar esta función. Si el cliente ha confirmado la recepción del pedido, el cadete recibe la tarifa del cadete, y el monto restante se transfiere al restaurante. Si el cliente no ha confirmado la recepción después de un tiempo determinado, se programará la destrucción de los fondos para evitar un bloqueo permanente de los mismos.

Función destroyFunds: Esta función permite destruir los fondos si no se ha confirmado la recepción del pedido después de un cierto período de tiempo. Esto se hace utilizando la función selfdestruct, que envía los fondos restantes al remitente de la transacción.


Eventos: El contrato emite tres eventos (OrderCreated, OrderPaid y FundsReleased) que sirven para registrar las acciones importantes que ocurren en el contrato. Estos eventos pueden ser escuchados por aplicaciones externas para mantener un registro de las actividades en el contrato.

En resumen, este contrato inteligente facilita la gestión de pedidos de comida en Ethereum. Los restaurantes, clientes y cadetes interactúan con el contrato para crear, pagar y liberar fondos de pedidos. El contrato asegura que los fondos se manejen de manera segura y automatizada, evitando problemas de confianza en el proceso de entrega.

### Direccion de Lightning Network de Bitcoin:
lnbc1pjsrhl9pp5ry62zxg8kf4hzhc6ctsnjf07z9s5082hu7vf4x20v8m8f03zpfksdqqcqzzgxqyz5vqrzjqwnvuc0u4txn35cafc7w94gxvq5p3cu9dd95f7hlrh0fvs46wpvhdm59mhnttn2ksqqqqqryqqqqthqqpyrzjqw8c7yfutqqy3kz8662fxutjvef7q2ujsxtt45csu0k688lkzu3ldm59mhnttn2ksqqqqqryqqqqthqqpysp5e0lv4cf494t534nc54tfefuwkq26jnunhuk5806a6xrt03gnrrqq9qypqsq3vqdnuhh5apl53a2q0675tsx6kk656qvkvhcpdl3nd4wgvajf8j9dmzfl0hphcz4tewhwuqlmcslss8msf97vq8t5clu84q2q8ek60qpjw5wgs
