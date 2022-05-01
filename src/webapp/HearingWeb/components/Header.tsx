import { colors } from "../colors"
import "../styles.css"
import React from "react"
import { useNavigate } from "react-router"
import { connectBluetoothDevices } from "../bluetooth/Bluetooth";

declare var require: any
var React = require('react');

export const Header = () => {
    const navigate = useNavigate();
    return (
            <div style={{position: "sticky", top: 0}}>
                <table className="headerTable">
                    <tr>
                        <td/>
                        <td >
                            <img src={require('../images/hearringtransparent.png').default} alt="heaRING logo" style={{ width: "200"}}></img>
                        </td>
                        <td className="subHeader">hear for you.</td>
                </tr>
                </table>
                <table className="headerTable">
                    <tr style={{ height: "40" }}>
                        <td onClick={() => navigate('/', {replace: true})} className="headerTab" style={{ backgroundColor: colors.headertab1 }}>About hearRING</td>
                        <td onClick={() => navigate('/faq', {replace:true})} className="headerTab" style={{ backgroundColor: colors.headertab3 }}>FAQ</td>
                    </tr>
                </table>
            </div>
       );    

}