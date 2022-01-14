import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');

function HowToConnect() {
    const navigate = useNavigate();
    return (
        <div>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">How To Connect</div>
            <label>What is your operating system?</label>
            <table>
                <tr>
                    <td><button onClick={() => navigate("/howtoconnect/windows")}>Windows</button></td>
                    <td><button onClick={() => navigate("/howtoconnect/mac")}>MacOS</button></td>
                    <td><button onClick={() => navigate("/howtoconnect/linux")}>Linux</button></td>
                    <td><button onClick={() => navigate("/howtoconnect/ios")}>iOS</button></td>
                    <td><button onClick={() => navigate("/howtoconnect/android")}>Android</button></td>
                </tr>
            </table>
        </div>);
}


export default HowToConnect;

function OSOnClick(osType) {
    switch (osType) {
        case OS.Windows:
            break;
        case OS.Mac:
            break;
        case OS.Linux:
            break;
        case OS.iOS:
            break;
        case OS.Android:
            break;
        default:
            break;
    }
}

enum OS {
    Windows, 
    Mac, 
    Linux,
    iOS,
    Android
}