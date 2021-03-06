import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');


function HowToConnectWindows() {
    const navigate = useNavigate();
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab3 }}>
            <Header style={{ width: "100%" }} />
            <div className="pagePanel" >
                <div style={{ width: "100%", display: "inline-block"}}>
                    <label className="pageHeader">How To Connect on Windows</label>
                    <button style={{ float: "right", position: "relative"}} className="buttonSmall" onClick={() => navigate('/howtoconnect', { replace: true })}>Back</button>
                </div>
                <div className="divider"/>
                <div>
                <p className="subHeader">Connect to the hearRING device on your computer</p>
                <p className="indentedBodyText">
                    Locate the "Settings" application on your computer. You should be able to search for it on the left side of your taskbar. <br />
                    Select the "Devices" option and click on "Bluetooth and other devices".<br />
                    Click "Add Bluetooth or other device".<br />
                    If prompted to choose a type of device, select bluetooth.<br />
                    Find the hearRING bracelet on the list.<br />
                        Select the hearRING bracelet, and you should be connected!<br />
                    </p>
                </div>
            </div>
        </div>
    );
}
export default HowToConnectWindows;
