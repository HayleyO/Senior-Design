import { Header } from "../components/Header";
import "../styles.css"

declare var require: any
var React = require('react');

function Settings() {
    return (
        <div>
            <Header style={{ width: "100%" }} />
            <div>settings</div>
        </div>);
}

export default Settings;