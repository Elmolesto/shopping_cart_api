# Shopping Cart API

This repository contains a very simple API for a shopping cart developed with Ruby on Rails.

## Overview

While it's too simple for a real-world use case, it was implemented with the aim of demonstrating the creation of a RESTful API with Ruby on Rails.
The API allows the client to perform the following actions:

- Create a shopping cart.
- Add items to the shopping cart.
- Modify the quantity of items in the cart.
- Delete items from the cart.
- Obtain the cart invoice with totals and subtotals for each item.

The logic for creating a cart and using the functionalities will be handled by the client consuming the API.

## Instructions

### To run the application

Make sure you have Ruby 3.1.2 and PostgreSQL installed.

- Clone the repository
- Install dependencies with `bundle install`
- Create the database with `rails db:create`
- Run migrations with `rails db:migrate`
- Seed the database with `rails db:seed`
- Run tests with `rails test`
- Start the server with `rails s`

### To run the application in Docker

- Build the image with `docker build`
- Run the app with `docker-compose up`
- Run the tests with `docker-compose run web bin/rails test`

### To use the API
- Use the Postman collection included in the repository.

## Data Model

The API has the following models:
- Item: It's the base model for products and events. It has attributes shared by both types of items. It uses a jsonb field to store the specific attributes of each type of item.
- Product: Represents a product. Saves the stock in the jsonb field. Inherited from Item.
- Event: Represents an event. Saves the event date in the jsonb field. Inherited from Item.
- Cart: Represents a shopping cart. It has a many-to-many relationship with Item through CartItem.
- CartItem: Represents an item in a shopping cart. Saves the quantity of items added to the cart.

## Endpoints

All endpoints are under the prefix `/api/v1`.
Attached is the Postman collection to use the API.

#### GET /api/v1/items
Gets the list of items available to add to the cart.

#### POST /api/v1/carts
Creates a new shopping cart. Returns the id of the created cart.

#### GET /api/v1/carts/:cart_id
Gets the information of a shopping cart. Requires the cart id. Returns the cart information with the items it contains.

#### POST /api/v1/carts/:cart_id/add/:item_id
Adds an item to the cart. Requires the cart id and the item id.
Returns the updated totals of the cart and the created or updated cart_item.

#### DELETE /api/v1/carts/:cart_id/remove/:item_id
Deletes an item from the cart. Requires the cart id and the item id.
Returns the updated totals of the cart and the updated or deleted cart_item.

## Error Handling

The API handles the following errors:
- 404 Not Found: When a resource is not found, e.g., a cart.
- 422 Unprocessable Entity: When an item cannot be added to the cart, e.g., if the item does not have enough stock, or if an attempt is made to remove an item that is not in the cart.

## Weaknesses and Issues

- It's not defined if the stock should be locked when adding an item to the cart. I assumed it's not locked until the purchase is completed.
- There's no stock management, only verification that the item has sufficient stock before adding it to the cart.
- Product and event images are not stored in the database, only the image URL is saved.
- To start working with the API, a cart must be created first. Items cannot be added to a non-existent cart.
- An item cannot be completely removed from the cart, only the quantity of items can be decreased.
- There should be logic to delete abandoned carts.

## Areas for Improvement

- Ability to create products with images.
- Add stock management. Change the stock logic for products and modeling.
- Allow deleting an item completely from the cart.