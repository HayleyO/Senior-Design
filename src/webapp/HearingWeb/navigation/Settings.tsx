import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');

function Settings() {
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab2 }}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">Settings</div>
        </div>
    );
}

export default Settings;