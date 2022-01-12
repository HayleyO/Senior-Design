import { colors } from "../colors"
import "../styles.css"
import "../navigation/Navigation"
import { Pages } from "../navigation/Pages"
import { headerTabOnClick } from "../navigation/Navigation"
import { Link, BrowserRouter, Routes, Route, useNavigate, HashRouter } from "react-router-dom"
import Home from "../navigation/Home"
import React from "react"

declare var require: any

var React = require('react');

export class Header extends React.Component {
    render(){
        return (
            <div>
                <table className="headerTable">
                    <tr>
                        <td/>
                        <td >
                            <img src="images\hearringtransparent.png" alt="heaRING logo" style={{ width: "200"}}></img>
                        </td>
                        <td>The Hearing Bracelet</td>
                    </tr>
                    <tr style={{ height: "40" }}>
                            <td onClick={() => "navigate('/', {replace = true})"} className="headerTab" style={{ backgroundColor: colors.headertab1 }}>Home</td>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab2 }}>Settings</td>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab3 }}>How To Connect</td>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab4 }}>About</td>
                    </tr>
                </table>
                </div>
       );    
    }
}