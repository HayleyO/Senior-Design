import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');

function HowToConnect() {
    const navigate = useNavigate();
    return (
        <div className="pageBackground" style = {{ backgroundColor: colors.headertab1 }}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">How To Connect</div>
            <div style={{width:"100%", height:"10"}}/>
            <div style={{ width: "100%", textAlign: "center" }}>What is your operating system?</div>
            <table style={{tableLayout:"fixed", width:"100%"}}>
                <tr>
                    <td />
                    <td>
            <table>
                <tr>
                    <td><button className = "button" onClick={() => navigate("/howtoconnect/windows")}>Windows</button></td>
                    <td><button className="button" onClick={() => navigate("/howtoconnect/mac")}>MacOS</button></td>
                    <td><button className="button" onClick={() => navigate("/howtoconnect/linux")}>Linux</button></td>
                    <td><button className="button" onClick={() => navigate("/howtoconnect/ios")}>iOS</button></td>
                    <td><button className="button" onClick={() => navigate("/howtoconnect/android")}>Android</button></td>
                </tr>
                        </table>
                    </td>
                    <td/>
                    </tr>
                </table>
        </div>);
}


export default HowToConnect;