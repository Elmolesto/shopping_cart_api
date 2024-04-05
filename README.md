# Shopping Cart API
Este repositorio contiene una API muy simple para un carrito de compras desarrollada con Ruby on Rails.

## Descripción general
Si bien es demasiado simple para un caso de uso real, se implementó con el objetivo de demostrar la creación de una API RESTful con Ruby on Rails.
La API permite al cliente realizar las siguientes acciones:

Crear un carrito de compras.
Agregar elementos al carrito de compras.
Modificar la cantidad de elementos en el carrito.
Eliminar elementos del carrito.
Obtener la factura del carrito con los totales y subtotales de cada ítem.

La lógica de creación de carrito y el uso de las funcionalidades quedaran a cargo del cliente que consuma la API.

## Instrucciones
### Para ejecutar la aplicación
Tener instalado Ruby 3.1.2 y postgresql.

- Clonar el repositorio
- Instalar las dependencias con `bundle install`
- Crear la base de datos con `rails db:create`
- Correr las migraciones con `rails db:migrate`
- Correr los seeders con `rails db:seed`
- Iniciar el servidor con `rails s`

### Para ejecutar los tests
- Correr los tests con `rails test`

### Para correr la aplicación en Docker
- Construir la imagen con `docker build`
- Correr docker compose con `docker-compose up`
- Utilizar la colección de Postman para probar los endpoints.

### Para correr los tests en Docker
- Construir la imagen con `docker build`
- Correr docker compose con `docker-compose run web bin/rails test`

## Modelo de datos
La API cuenta con los siguientes modelos:
- Item: Es el modelo base para los productos y los eventos. Tiene los atributos que comparten ambos tipos de ítems. Usa un campo jsonb para almacenar los atributos específicos de cada tipo de ítem.
- Product: Representa un producto. Guarda el stock en el campo jsonb.
- Event: Representa un evento. Guarda la fecha del evento en el campo jsonb.
- Cart: Representa un carrito de compras. Tiene una relación de muchos a muchos con Item a través de CartItem.
- CartItem: Representa un ítem en un carrito de compras. Guarda la cantidad de ítems que se agregaron al carrito.


## Endpoints
Todos los endpoints están bajo el prefijo `/api/v1`. 
Adjunto la colección de Postman para probar los endpoints.

#### GET /api/v1/items
Obtiene la lista de ítems disponibles para agregar al carrito.

#### POST /api/v1/carts
Crea un nuevo carrito de compras. Retorna el id del carrito creado.

#### GET /api/v1/carts/:cart_id
Obtiene la información de un carrito de compras. Requiere el id del carrito. Retorna la información del carrito con los ítems que contiene.

#### POST /api/v1/carts/:cart_id/add/:item_id
Agrega un ítem al carrito. Requiere el id del carrito y el id del ítem.
Retorna los totales actualizados del carrito y el cart_item creado o actualizado.

#### DELETE /api/v1/carts/:cart_id/remove/:item_id
Elimina un ítem del carrito. Requiere el id del carrito y el id del ítem. 
Retorna los totales actualizados del carrito y el cart_item actualizado o eliminado.


## Gestión de errores
La API maneja los siguientes errores:
- 404 Not Found: Cuando no se encuentra un recurso, ej: un carrito.
- 422 Unprocessable Entity: Cuando no se puede agregar un ítem al carrito, ej: si el ítem no tiene stock suficiente, o si se desea eliminar un ítem que no está en el carrito.

## Puntos flacos y problemas
- No está definido si el stock debe bloquearse al agregar un ítem al carrito. Supuse que no se bloquea hasta que se realiza la compra.
- No hay gestión de stock, solo se verifica que el ítem tenga stock suficiente zal agregarlo al carrito.
- Las imagenes de los productos y eventos no se guardan en la base de datos, solo se almacena la url de la imagen.
- Para empezar a trabajar con la API, se debe crear un carrito primero. No se puede agregar ítems a un carrito que no existe.
- No se puede eliminar un item por completo del carrito, solo se puede disminuir la cantidad de ítems.
- Debería haber una logica de borrado de carritos abandonados.

## Puntos a mejorar
- Poder crear productos con imágenes.
- Agregar gestión de stock. Cambiar la lógica de stock para los productos y el modelado
- Permitir eliminar un ítem por completo del carrito.