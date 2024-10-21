# Daily BIT

Daily BIT is a Ruby on Rails API application that integrates with the CoinDesk API to provide real-time BTC-USD price data. It allows users to perform buy and sell Bitcoin transactions, and features include balance validation and updates.

## Features

- **Real-Time Bitcoin Price:** Fetches the latest BTC-USD price using the [CoinDesk API](https://api.coindesk.com/v1/bpi/currentprice.json).
- **Buy and Sell Transactions:** Users can perform Bitcoin transactions using USD.
- **Balance Validation and Update:** Ensures users have a sufficient balance of the sent currency and updates balance after transaction accordingly.
- **Transaction History:** Maintains records of each user's buy and sell transactions.

## Development

To set up the project locally, follow these steps:

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/karlavdelgadof/Daily-BIT.git
   cd Daily-BIT
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate 
   ```

4. Run the server:
   ```bash
   rails server
   ```

5. Visit `http://localhost:3000` in your browser to access the application.

### Running Tests

To run the test suite, use:

```bash
bundle exec rspec
```

## API Documentation
Detailed documentation for the Daily BIT API can be found on Postman:

[Daily BIT API Documentation - Postman](https://red-moon-211001.postman.co/workspace/My-Workspace~a37a6229-046d-45fd-8060-64047480f853/collection/24949874-38af18a2-461c-4a9c-86ef-64b51e374669?action=share&creator=24949874)

## Deployment

The project is currently deployed at:

[Daily BIT API - Live](https://your-deployment-url.com)


