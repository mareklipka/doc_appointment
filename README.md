
### Prerequisites

* Ruby 3.2.2
* Bundler

### Installation

1. Clone the repository
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:create db:schema:load`
4. Load some example data: `rails db:seed`
5. Start the server: `rails s`

### Usage

There's a swagger JSON doc file at http://localhost:3000/api/swagger_doc.json

### Running the Tests

Run the test suite with the following command: `rails spec`
