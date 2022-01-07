import { colors } from "./colors"
import "./styles.css"
declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

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
                    <tr style={{height: "40"}}>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab1 }}>Home</td>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab2 }}>Settings</td>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab3 }}>How To Connect</td>
                        <td className="headerTab" style={{ backgroundColor: colors.headertab4 }}>About</td>
                    </tr>
                </table>
            </div>);    
    }
}