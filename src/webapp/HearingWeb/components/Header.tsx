import { colors } from "../colors"
import "../styles.css"
import React from "react"
import { useNavigate } from "react-router"

declare var require: any
var React = require('react');

export const Header = () => {
    const navigate = useNavigate();
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
                        <td onClick={() => navigate('/', {replace: true})} className="headerTab" style={{ backgroundColor: colors.headertab1 }}>Home</td>
                        <td onClick={() => navigate('/settings', { replace: true })} className="headerTab" style={{ backgroundColor: colors.headertab2 }}>Settings</td>
                        <td onClick={() => navigate('/howtoconnect', { replace: true })} className="headerTab" style={{ backgroundColor: colors.headertab3 }}>How To Connect</td>
                        <td onClick={() => navigate('/about', {replace:true})} className="headerTab" style={{ backgroundColor: colors.headertab4 }}>About</td>
                    </tr>
                </table>
                </div>
       );    

}