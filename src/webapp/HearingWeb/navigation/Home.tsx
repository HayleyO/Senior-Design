//import { table } from "console";
import { Header } from "../components/Header";
//import { Routes, Route, Router, BrowserRouter } from "react-router-dom";
import "../styles.css"
import React from "react"

declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

function Home() {
    return (
        <Header style={{ width: "100%" }} />);
}

export default Home;