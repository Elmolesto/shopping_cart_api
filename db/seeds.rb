Product.create(
  name: "Gafas de sol Carey", 
  description: "Gafas de sol de pasta Carey",
  thumbnail: "https://placehold.co/400x400",
  type: "Product", 
  stock: 3, 
  price_cents: 3999
)
Product.create(
  name: "Producto de ejemplo 2",
  description: "Descripción de producto de ejemplo 2",
  thumbnail: "https://placehold.co/400x400",
  type: "Product", 
  stock: 5, 
  price_cents: 2999
)

Event.create(
  name: "Red Hot Chili Peppers en Madrid", 
  description: "Concierto de Red Hot Chili Peppers en Madrid",
  thumbnail: "https://placehold.co/400x400",
  type: "Event", 
  date: Date.today + 1.week, 
  price_cents: 6000,
)
Event.create(
  name: "Evento de ejemplo 2", 
  description: "Descripción de evento de ejemplo 2",
  thumbnail: "https://placehold.co/400x400",
  type: "Event", 
  date: Date.today + 2.weeks, 
  price_cents: 4000,
)
