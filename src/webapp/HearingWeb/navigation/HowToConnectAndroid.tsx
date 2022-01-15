import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');


function HowToConnectAndroid() {
    const navigate = useNavigate();
    return (
        <div className="pageBackground" style = {{ backgroundColor: colors.headertab1 }}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">Android</div>
            <button onClick={() => navigate('/howtoconnect', { replace: true })}>Back</button>
            <div className="pagePanel" />
        </div>
    );
}
export default HowToConnectAndroid;
