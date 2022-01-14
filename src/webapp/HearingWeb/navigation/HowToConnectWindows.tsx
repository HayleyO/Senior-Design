import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');


function HowToConnectWindows() {
    const navigate = useNavigate();
    return (
        <div>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">Windows</div>
            <button onClick={() => navigate('/howtoconnect', {replace:true})}>Back</button>
        </div>
    );
}
export default HowToConnectWindows;
