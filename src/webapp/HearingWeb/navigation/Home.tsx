import { Header } from "../components/Header";
import "../styles.css";
import { colors } from "../colors.js";
import { TextboxButtonsTTS } from "../components/TextboxButtonsTTS";
import { SpeechToTextOutput } from "../components/SpeechToTextOutput";

declare var require: any
var React = require('react');

function Home() {
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab1}}>
            <Header style={{ width: "100%" }} />
            <table style={{ tableLayout: "fixed", width: "100%", marginTop:"15"}}>
                <tr>
                    <td style={{ width: "50%", verticalAlign: "top", textAlign: "center" }}>
                        <label className="pageHeader">Speech To Text</label>
                        <SpeechToTextOutput />
                    </td>
                    <td style={{ width: "50%", verticalAlign: "middle", textAlign: "center" }}>
                        <label className="pageHeader">Text To Speech</label>
                        <TextboxButtonsTTS />
                    </td>
                </tr>
            </table>
            </div>
    );
}

export default Home;