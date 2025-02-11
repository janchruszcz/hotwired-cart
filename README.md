# Hotwired Cart

A simple, mini shopping cart application built with Ruby on Rails and Hotwire, featuring real-time updates and a clean, modern interface.

## Features

- Real-time cart updates using Hotwire
- Dynamic quantity adjustments
- Item removal
- Cart reset functionality
- Discount slider with debounced updates
- Clean, responsive design with Tailwind CSS

## Tech Stack

- Ruby 3.2.2
- Rails 8.0.0
- SQLite
- Hotwire (Turbo + Stimulus)
- Tailwind CSS
- Active Storage for product images

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd hotwired-cart
```

2. Install dependencies:
```bash
bundle install
```
3. Setup the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```
4. Start the server:
```bash
./bin/dev
```