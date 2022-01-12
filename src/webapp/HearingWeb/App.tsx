import { table } from "console";
import { Header } from "./components/Header";
import { Routes, Route, Router, BrowserRouter, HashRouter } from "react-router-dom";
import "./styles.css"
import Home from "./navigation/Home";
import React from "react"

declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

export class App extends React.Component {
    render() {
        return (
            <div>
                <HashRouter>
                    <Routes>
                        <Route path="/" element={<Home />} />
                    </Routes>
                </HashRouter></div>
        );
    }

}

ReactDOM.render(<App/>, document.getElementById('root'));