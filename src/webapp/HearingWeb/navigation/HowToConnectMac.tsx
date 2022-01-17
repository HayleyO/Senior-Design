import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');


function HowToConnectMac() {
    const navigate = useNavigate();
    return (
        <div className="pageBackground" style = {{ backgroundColor: colors.headertab3 }}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">Mac</div>
            <button onClick={() => navigate('/howtoconnect', { replace: true })}>Back</button>
            <div className="pagePanel" />
        </div>
    );
}
export default HowToConnectMac;
