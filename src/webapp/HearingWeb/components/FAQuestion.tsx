import { colors } from "../colors"
import "../styles.css"
import React from "react"
declare var require: any
var React = require('react');

export const FAQuestion = (props) => {
    return (
            <div>
        <div className="pagePanel">
                <table style={{width:"100%"}}>
            <tr>
                <td>
                   <div className="subHeader">{props.header}</div>
                        </td>
                        <td style={{ textAlign: "right", borderColor: "azure", backgroundColor: "azure" }} id="button" onClick={(e) => open(e, props.body)}><button>v</button></td>
                        </tr>
                </table>
                <div id="answer" className="indentedBodyText" ></div>

            </div>
            <script type="text/javascript">
               
            </script>
            </div>
            )
}

const open = (event: React.MouseEvent<HTMLButtonElement>, body) => {
    var ans = document.getElementById("answer")

    if (ans != null) {
        ans.innerHTML = body
    }
}

