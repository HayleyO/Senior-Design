import { colors } from "../colors"
import "../styles.css"
import React from "react"
declare var require: any
var React = require('react');

export function FAQuestion(props){
    return (
        <div className="pagePanel">
            <table style={{width:"100%"}}>
                <tr>
                    <td><div className="subHeader">{props.header}</div></td>
                    <td className="button" style={{ textAlign: "right" }} onClick={(e) => open(e, props.body, props.qid)}>
                        <button className="button" name="button" style={{ textAlign: "right" }} >view</button>
                    </td>
                </tr>
            </table>
            <div name="answer" className="indentedBodyText" ></div>

            </div>)
}

const open = (event: React.MouseEvent<HTMLButtonElement>, body, qid) => {
    var ans = document.getElementsByName("answer")[qid]
    var button = document.getElementsByName("button")[qid]

    if (ans.innerHTML == "") {
        ans.innerHTML = body
        button.innerHTML = "hide"
    }
    else {
        ans.innerHTML = ""
        button.innerHTML = "view"
    }
}

