import { Header } from "../components/Header";
import "../styles.css"

declare var require: any
var React = require('react');

function HowToConnect() {
    return (
        <div>
            <Header style={{ width: "100%" }} />
            <div>how to connect</div>
        </div>);
}

export default HowToConnect;