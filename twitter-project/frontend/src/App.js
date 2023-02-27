import logo from './logo.svg';
import React, { useEffect, useState } from 'react';
import './App.css';

const server_port = 8080

function App() {
  const [Response, setResponse] = useState(0);

  const callAPI = (() => {
    fetch("http://localhost:" + server_port + "/modules")
      .then(res => res.text())
      .then(res => setResponse(res));
  })

  useEffect(() => {
    callAPI();
  }, [])

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <p className="App-intro">{Response}</p>
      </header>
    </div>
  );
}

export default App;
