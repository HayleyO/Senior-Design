import { Routes, Route, HashRouter } from "react-router-dom";
import "./styles.css"
import Home from "./navigation/Home";
import About from "./navigation/About";
import HowToConnect from "./navigation/HowToConnect";
import Settings from "./navigation/Settings";

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
                        <Route path="/about" element={<About />} />
                        <Route path="/howtoconnect" element={<HowToConnect />} />
                        <Route path="/settings" element={<Settings />} />
                    </Routes>
                </HashRouter>
            </div>
        );
    }

}

ReactDOM.render(<App/>, document.getElementById('root'));