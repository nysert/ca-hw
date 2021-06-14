import './App.css';
import React, { useState, useEffect } from 'react';

function App() {
  const [loading, setLoading] = useState(false);
  const [brand, setBrand] = useState('');
  const [model, setModel] = useState('');
  const [mileage, setMileage] = useState('');
  const [price, setPrice] = useState('');
  const [year, setYear] = useState('');
  const [vehicles, setVehicles] = useState([]);

  useEffect(() => {
    search()
  }, [])

  function updateQuery(obj, key, value) {
    if (value !== "") {
      obj[key] = value;
    }
    return obj;
  }

  function queryString(obj) {
    return Object.keys(obj)
      .reduce((a, k) => {
        a.push(k + '=' + encodeURIComponent(obj[k]))
        return a
      }, [])
      .join('&')
  }

  function search() {
    setLoading(true)

    let query = {}
    updateQuery(query, "brand_name", brand)
    updateQuery(query, "model_name", model)
    updateQuery(query, "lt_mileage", mileage)
    updateQuery(query, "lt_price", price)
    updateQuery(query, "gt_year", year)

    fetch(`http://localhost:3000/vehicles?${queryString(query)}`, {
      "method": "GET",
      "headers": {
        "Content-Type": "application/json"
      },
    })
    .then(response => response.json())
    .then(data => {
      setVehicles(data)
      setLoading(false)
    })
    .catch(err => setLoading(false));
  }

  function renderVehicles() {
    if (loading) {
      return(
        <div className="vehicle-empty">
          <div className="title">
            Searching for Vehicles
          </div>
        </div>
      )
    } else if (vehicles.length === 0) {
      return(
        <div className="vehicle-empty">
          <div className="title">
            No Vehicles Found
          </div>
        </div>
      )
    } else {
      return(
        vehicles.map(v =>
          <div className="vehicle" key={`vehicle-${v.id}`}>
            <div className="header">{v.brand_name} {v.model_name} {v.year}</div>
            <div className="image-container">
              <img src="https://raw.githubusercontent.com/nysert/ca-hw/master/frontend/image.png" alt="" />
            </div>
            <div className="footer">
              <div className="price">${v.price}</div>
              <div className="mileage">{v.mileage}km</div>
            </div>
          </div>
        )
      )
    }
  }

  return (
    <div>
      <div className="navbar">
        <div className="brand">Luis</div>
      </div>
      <div className='App'>
        <div className="search">
          <h1 className="title">Search for your next car!</h1>
          <div className="input-group">
            <label>Brand</label>
            <input type='text' value={brand} onChange={e => setBrand(e.target.value)}/>
          </div>
          <div className="input-group">
            <label>Model</label>
            <input type='text' value={model} onChange={e => setModel(e.target.value)}/>
          </div>
          <div className="input-group">
            <label>Mileage</label>
            <input type='number' value={mileage} onChange={e => setMileage(e.target.value)}/>
          </div>
          <div className="input-group">
            <label>Price</label>
            <input type='number' value={price} onChange={e => setPrice(e.target.value)}/>
          </div>
          <div className="input-group">
            <label>Year</label>
            <input type='number' value={year} onChange={e => setYear(e.target.value)}/>
          </div>
          <div className="input-group input-search">
            {
              loading
                ?
                  <div id="html-spinner"></div>
                :
                  <button className="button" onClick={search}>Search</button>
            }
          </div>
        </div>
        <div className="vehicles-list">
          {renderVehicles()}
        </div>
      </div>
    </div>
  );
}

export default App;
