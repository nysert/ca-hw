# Run api
- go to /api `cd api` install dependencies `bundle install`
- init db with: `rake db:create` `rake db:migrate` `rake db:seed`
- start api server with `rails s`
- to create vehicles run the following curl changing the POST data:
```bash
curl --request POST \
  --url http://localhost:3000/vehicles \
  --header 'Content-Type: application/json' \
  --data '{
  "brand": "VW",
  "model": "Golf",
  "year": "2020",
  "price": 100000,
  "mileage": 90000
}'
```
- to run test do `rails test`

# Run frontend
- go to /frontend install dependencies `npm install`
- start frontend server with `npm start`

make sure to have frontend and api server on at the same time
