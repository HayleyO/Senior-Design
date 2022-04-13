import { colors } from "../colors"
import "../styles.css"

declare var require: any
var React = require('react');

export const FAQuestion = (props) => {
        return(
        <div className="pagePanel">
                <table style={{width:"100%"}}>
            <tr>
                <td>
                   <div className="subHeader">{props.header}</div>
                        </td>
                        <td style={{ textAlign: "right", border: "none", backgroundColor: "azure" }} onClick={open(props.body)}><button>v</button></td>
                </tr>
                </table>
            </div>
            )
}

function open(text) {
    return (
        <div className="indentedBodyText">{text}</div>
    );
}