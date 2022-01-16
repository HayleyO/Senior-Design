import { Header } from "../components/Header";
import "../styles.css";
import { colors } from "../colors.js";
import { TextboxButtonsTTS } from "../components/TextboxButtonsTTS";

declare var require: any
var React = require('react');

function Home() {
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab1 }}>
            <Header style={{ width: "100%" }} />
            <TextboxButtonsTTS />
            </div>
    );
}

export default Home;