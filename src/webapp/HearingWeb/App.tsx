import { Routes, Route, HashRouter } from "react-router-dom";
import "./styles.css"
import Home from "./navigation/Home";
import About from "./navigation/About";
import HowToConnect from "./navigation/HowToConnect";
import HowToConnectWindows from "./navigation/HowToConnectWindows";
import HowToConnectMac from "./navigation/HowToConnectMac";
import HowToConnectLinux from "./navigation/HowToConnectLinux";
import HowToConnectIOS from "./navigation/HowToConnectIOS";
import HowToConnectAndroid from "./navigation/HowToConnectAndroid";
import Settings from "./navigation/Settings";
import { TextboxButtonsTTS } from "./components/TextboxButtonsTTS";


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
                        <Route path="/howtoconnect" element={<HowToConnect />} />
                        <Route path="/howtoconnect/windows" element={<HowToConnectWindows />} />
                        <Route path="/howtoconnect/mac" element={<HowToConnectMac />} />
                        <Route path="/howtoconnect/linux" element={<HowToConnectLinux />} />
                        <Route path="/howtoconnect/ios" element={<HowToConnectIOS />} />
                        <Route path="/howtoconnect/android" element={<HowToConnectAndroid />} />
                    </Routes>
                </HashRouter>
                <TextboxButtonsTTS />
            </div>
        );
    }

}

ReactDOM.render(<App/>, document.getElementById('root'));